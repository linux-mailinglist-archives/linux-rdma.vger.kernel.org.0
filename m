Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D881D7AC634
	for <lists+linux-rdma@lfdr.de>; Sun, 24 Sep 2023 03:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjIXBl4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Sep 2023 21:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjIXBl4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 23 Sep 2023 21:41:56 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA292180;
        Sat, 23 Sep 2023 18:41:49 -0700 (PDT)
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
        by cmsmtp with ESMTP
        id k7Q2qwjv9EoVskE84qKPpz; Sun, 24 Sep 2023 01:41:49 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id kE83qrrpTPNASkE83qgI1T; Sun, 24 Sep 2023 01:41:48 +0000
X-Authority-Analysis: v=2.4 cv=X8FBlUfe c=1 sm=1 tr=0 ts=650f93dc
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=cm27Pg_UAAAA:8 a=YSKGN3ub9cUXa_79IdMA:9 a=QEXdDO2ut3YA:10
 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QlO38JItyn9oJ4bwMUFFP3FqsNzwUMOqMup3Pv/RlbM=; b=Gkx26kuo9o/AJL/iYhzFoN09LU
        WMsmG9IcUJxXG+VvqHMCURZfGBb+vkFjRPVV0Pwn7QDXGghrOgZo79R3x/hScOMDhaGal8jrU2DD4
        sCxs/0oGyUdDvFfx7KlDZcXymiMW539jiVOum6/5rFS3mbqjhwQUbM6MAVyuatF34tgKAdEovYTVz
        rTytP47tAxm3PfG/B0A+ZheMpSXUu+CRwsPjV7baGkJ7mJKZm8zzVNHpBv5pjlrHsLXpn2OFAtH38
        Bxq/ldFDJSheMZPRsy6HvD2R8uLLn2tobWxoCyXerJiQIVeLDzmE7iAMTTS3LFH5m3IFAN3tg8ysK
        F6suFvzw==;
Received: from [94.239.20.48] (port=55626 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjkIo-000075-35;
        Fri, 22 Sep 2023 12:50:55 -0500
Message-ID: <dd13a477-96b5-4348-eeeb-14f21319ed39@embeddedor.com>
Date:   Fri, 22 Sep 2023 19:51:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 04/14] net: hns: Annotate struct ppe_common_cb with
 __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc:     Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        David Ahern <dsahern@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        Alex Elder <elder@kernel.org>,
        Pravin B Shelar <pshelar@ovn.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-rdma@vger.kernel.org, dev@openvswitch.org,
        linux-parisc@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20230922172449.work.906-kees@kernel.org>
 <20230922172858.3822653-4-keescook@chromium.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922172858.3822653-4-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qjkIo-000075-35
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:55626
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNJpHygesTnC9s4/oKhsiSlt39atOTOWtv0wJ1wVifhALYIJgEbY4fx/e1uMwTYJ3/8CRN5d3KuTZbbtkim+x5p+/obVSjygLkB93NEpyPKF1THf9WIC
 FCMpFVXXS5HFy1i09t6eTnCSsdXJcltIMiF/7oEdZagp/qFb/RmYoP7hW609X2twlv+xv1qjaaP7zPTJ5Bq+zZ+dTZQKwZBOkHnJQjQ6YDFcie3GoIDxPV9K
 xBBc0wDxcVz04PQXWuiJImSLZCoZTD1O7NkZGRKYWKrSQ1vqBwaO0casmMyjDhykoiJnYGI4OQofBH3kycEiZtXPpMZoNqPgmHpxclNpHeqPvOidWW3koSfT
 roA3/Ne0t4hupZ8ACDMliQXE3dsBHni6H09yww2yse6efyr751H/f9vfHTJ7RKUYinqy1wbD
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 9/22/23 11:28, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ppe_common_cb.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
> Cc: Salil Mehta <salil.mehta@huawei.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
> index 0f0e16f9afc0..7e00231c1acf 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
> @@ -92,7 +92,7 @@ struct ppe_common_cb {
>   	u8 comm_index;   /*ppe_common index*/
>   
>   	u32 ppe_num;
> -	struct hns_ppe_cb ppe_cb[];
> +	struct hns_ppe_cb ppe_cb[] __counted_by(ppe_num);
>   
>   };
>   
