Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB3856626B
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Jul 2022 06:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiGEEeN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Jul 2022 00:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiGEEeM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 Jul 2022 00:34:12 -0400
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7805311C32;
        Mon,  4 Jul 2022 21:34:10 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id o15so6516430pjh.1;
        Mon, 04 Jul 2022 21:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=34sMBxKY3iSU2n9g+Y96ia1v3q8J7jB8j3u/HMT8UcQ=;
        b=IQgoqr1GiAXZ9K0lHYS2V9iYfbAQj+u+L+2DIBQCljauEWmD416/cYqmKWJDlPmJyK
         SUHzW/GKBoESTIoinOoHZnhixLbWTs3quLLbbaaFm3m97sXcX6rTWkpoAuzCYqzFhd0C
         RNY9fWfA/k+2tHndZRzMFv1c8d1oaIoZ9zzhoBMuxu3JUhN/95/YucN+YFPi12HpK+if
         Q1aSSpa/LfqvQrhez+xek6i4fPOsWrtc0kkaItZMBGZL3p6JEvAPJyICekxMo34IoXyT
         7IvTg8wpapkTn44CTtenv63kSaIVc2pGvtj2mOF7kHKqHUD0U5y2UrjIrKMsz9N9cGqi
         Jvxg==
X-Gm-Message-State: AJIora+xC2U2gbkd2cNPwZk9optOcsclc3Tf6ouQ6CSObWivTBdgHfaj
        f3+ozrPHMbAbvp2ZJtxBKJk=
X-Google-Smtp-Source: AGRyM1sVJL5ctkqoOpHoE94yjYVkjrjznWiAjcYwbi8kB7zDgNEIX5xadjZgLjcjXxLgmoDcW13X/g==
X-Received: by 2002:a17:902:d583:b0:16a:29de:9dfb with SMTP id k3-20020a170902d58300b0016a29de9dfbmr38612954plh.44.1656995649756;
        Mon, 04 Jul 2022 21:34:09 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id f12-20020a170902684c00b0016bd6635b6csm5428342pln.278.2022.07.04.21.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 21:34:09 -0700 (PDT)
Message-ID: <a671867f-153c-75a4-0f58-8dcb0d4f9c19@acm.org>
Date:   Mon, 4 Jul 2022 21:34:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: use-after-free in srpt_enable_tpg()
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mike Christie <michael.christie@oracle.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <17649b9c-7e42-1625-8bc9-8ad333ab771c@fujitsu.com>
 <ed7e268e-94c5-38b1-286d-e2cb10412334@acm.org>
 <fbaca135-891c-7ff3-d7ac-bd79609849f5@oracle.com>
 <20220701015934.1105-1-hdanton@sina.com>
 <20220703021119.1109-1-hdanton@sina.com>
 <20220704001157.1644-1-hdanton@sina.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220704001157.1644-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/3/22 17:11, Hillf Danton wrote:
> On Sun, 3 Jul 2022 07:55:05 -0700 Bart Van Assche wrote:
>> However, I'm not sure that would make a
>> significant difference since there is a similar while-loop in one of the
>> callers of srpt_remove_one() (disable_device() in the RDMA core).
> 
> Hehe... feel free to shed light on how the loop in RDMA core is currently
> making the loop in srpt more prone to uaf?

In my email I was referring to the following code in disable_device():

        wait_for_completion(&device->unreg_completion);

I think that code shows that device removal by the RDMA core is 
synchronous in nature. Even if the ib_srpt source code would be modified 
such that the objects referred by that code live longer, the wait loop 
in disable_device() would wait for the ib_device reference counts to 
drop to zero.

So I do not expect that modifying object lifetimes in ib_srpt.c can lead 
to a solution.

Removing configfs directories from inside srpt_release_sport() could be 
a solution. However, configfs does not have any API to remove 
directories and I'm not aware of any plans to add such an API. 
Additionally, several kernel maintainers disagree with invoking the 
rmdir system call from inside kernel code.

A potential solution could be to decouple the lifetimes of the data 
structures used for configfs (struct se_wwn and struct srpt_tpg) and the 
data structures associated with RDMA objects (struct srpt_port). If 
nobody else beats me to this I will try to find the time to implement 
this approach.

Bart.
