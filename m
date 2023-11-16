Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64E37EDF0E
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Nov 2023 12:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjKPLDK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Nov 2023 06:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjKPLDJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Nov 2023 06:03:09 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B3D85;
        Thu, 16 Nov 2023 03:03:04 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VwW6en0_1700132581;
Received: from 30.221.129.201(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VwW6en0_1700132581)
          by smtp.aliyun-inc.com;
          Thu, 16 Nov 2023 19:03:02 +0800
Message-ID: <f5bc9020-8a7f-7280-fb65-2efb6bde032e@linux.alibaba.com>
Date:   Thu, 16 Nov 2023 19:02:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH net-next] net/smc: Introduce IPPROTO_SMC for smc
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1699442703-25015-1-git-send-email-alibuda@linux.alibaba.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <1699442703-25015-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2023/11/8 19:25, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patch attempts to initiate a discussion on creating smc socket
> via AF_INET, similar to the following code snippet:
> 
> /* create v4 smc sock */
> v4 = socket(AF_INET, SOCK_STREAM, IPPROTO_SMC);
> 
> /* create v6 smc sock */
> v6 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SMC);
> 
> As we all know, the way we currently create an SMC socket as
> follows.
> 
> /* create v4 smc sock */
> v4 = socket(AF_SMC, SOCK_STREAM, SMCPROTO_SMC);
> 
> /* create v6 smc sock */
> v6 = socket(AF_SMC, SOCK_STREAM, SMCPROTO_SMC6);
> 
> Note: This is not to suggest removing the SMC path, but rather to propose
> adding a new path (inet path).
> 
> There are several reasons why we believe it is much better than AF_SMC:
> 
> Semantics:
> 
> SMC extends the TCP protocol and switches it's data path to RDMA path if
> RDMA link is ready. Otherwise, SMC should always try its best to degrade to
> TCP. From this perspective, SMC is a protocol derived from TCP and can also
> fallback to TCP, It should be considered as part of the same protocol
> family as TCP (AF_INET and AF_INET6).
> 
> Compatibility & Scalability:
> 
> Due to the presence of fallback, we needs to handle it very carefully to
> keep the consistent with the TCP sockets. SMC has done a lot of work to
> ensure that, but still, there are quite a few issues left, such as:
> 
> 1. The "ss" command cannot display the process name and ID associated with
> the fallback socket.
> 
> 2. The linger option is ineffective when user try’s to close the fallback
> socket.
> 
> 3. Some eBPF attach points related to INET_SOCK are ineffective under
> fallback socket, such as BPF_CGROUP_INET_SOCK_RELEASE.
> 
> 4. SO_PEEK_OFF is a un-supported sock option for fallback sockets, while
> it’s of course supported for tcp sockets.
> 
> Of course, we can fix each issue one by one, but it is not a fundamental
> solution. Any changes on the inet path may require re-synchronization,
> including bug fixes, security fixes, tracing, new features and more. For
> example, there is a commit which we think is very valueable:
> 
> commit 0dd061a6a115 ("bpf: Add update_socket_protocol hook")
> 
> This commit allows users to modify dynamically the protocol before socket
> created through eBPF programs, which provides a more flexible approach
> than smc_run (LP_PRELOAD). It does not require the process restart
> and allows for controlling replacement at the connection level, whereas
> smc_run operates at the process level.
> 
> However, to benefit from it under the SMC path requires additional
> code submission while nothing changes requires to do under inet path.
> 
> I'm not saying that these issues cannot be fixed under smc path, however,
> the solution for these issues often involves duplicating work that already
> done on inet path. Thats to say, if we can be under the inet path, we can
> easily reuse the existing infrastructure.
> 
> Performance:
> 
> In order to ensure consistency between fallback sockets and TCP sockets,
> SMC creates an additional TCP socket. This introduces additional overhead
> of approximately 15%-20% for the establishment and destruction of fallback
> sockets. In fact, for the users we have contacted who have shown interest
> in SMC, ensuring consistency in performance between fallback and TCP has
> always been their top priority. Since no one can guarantee the
> availability of RDMA links, support for SMC on both sides, or if the
> user's environment is 100% suitable for SMC. Fallback is the only way to
> address those issues, but the additional performance overhead is
> unacceptable, as fallback cannot provide the benefits of RDMA and only
> brings burden right now.
> 
> In inet path, we can embed TCP sock into SMC sock, when fallback occurs,
> the socket behaves exactly like a TCP socket. In our POC, the performance
> of fallback socket under inet path is almost indistinguishable from of
> tcp socket, with less than 1% loss. Additionally, and more importantly,
> it has full feature compatibility with TCP socket.
> 

> Of course, it is also possible under smc path, but in that way, it
> would require a significant amount of work to ensure compatibility with
> tcp sockets, which most of them has already been done in inet path.
> And still, any changes in inet path may require re-synchronization.
> 
> I also noticed that there have been some discussions on this issue before.
> 
> Link: https://lore.kernel.org/stable/4a873ea1-ba83-1506-9172-e955d5f9ae16@redhat.com/
> 
> And I saw some supportive opinions here, maybe it is time to continue
> discussing this matter now.
> 

I see the reasons.

Since the introduction of IPPROTO_SMC could mean many works to current SMC
code. Could you give us a rough idea about what are you going to do in the
implementation?

And if the AF_INET+IPPROTO_SMC coexists with current AF_SMC, which one should
be chose in different situation?

Thanks,
Wen Gu


> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   include/uapi/linux/in.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
> index e682ab6..0c6322b 100644
> --- a/include/uapi/linux/in.h
> +++ b/include/uapi/linux/in.h
> @@ -83,6 +83,8 @@ enum {
>   #define IPPROTO_RAW		IPPROTO_RAW
>     IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
>   #define IPPROTO_MPTCP		IPPROTO_MPTCP
> +  IPPROTO_SMC = 263,		/* Shared Memory Communications		*/
> +#define IPPROTO_SMC		IPPROTO_SMC
>     IPPROTO_MAX
>   };
>   #endif
