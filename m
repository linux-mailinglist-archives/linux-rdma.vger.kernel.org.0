Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63A063DC8D
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Nov 2022 19:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiK3SAO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Nov 2022 13:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiK3SAL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Nov 2022 13:00:11 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FA855CB4;
        Wed, 30 Nov 2022 10:00:10 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id mv18so16407993pjb.0;
        Wed, 30 Nov 2022 10:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fjqJKTVQepvnvgSP+jfjlXiZpM1wFgFx6j+r4BZ42Q=;
        b=N6VMEnTWSlD5bbJKxJi+OgWbnuG2N8hFAgNHXB+V6oUtH7mWGCHo15kCODjKR4kz11
         wzwA++nTt7UO88QBQMbCNuAvfCe5vFfKSp+hC+47HTU053dx+m1i3wreRdbKbH3E1ix9
         /iGChu4Gty6fpbbVA6D9gJVO0MBbS4NnRhLSSCC4zSidnKq3RNKZ0k+VyY8nQcVtkcgZ
         /w39p9WFDp8ZCuG13v0IfPQYd/HvPys8JFQiwVpxHMOsfRCKO0c2K1nID2lWOXzM9Jy3
         AvTo6FjFPmokXPxuTsiLBdrlNIOIT+3RBuj+b5/oEUg3L2cpQNsRH7ZWl9XGWaiAjBmU
         WGQA==
X-Gm-Message-State: ANoB5plziWSt/zvhtglXzlTAd9tDqwyJsB7tJIG492QFK53dRJlWidEn
        mLy1zF9X+27VJ0m+8HH4/ok7NpU6xCw=
X-Google-Smtp-Source: AA0mqf4zlIE6PFFzQEXoSRG5BZm3/AfmkJQKeeaZYdJLeb1CC/BynWhFGZQ5ShM+GQr01BeIbwZf3w==
X-Received: by 2002:a17:902:db09:b0:188:7dca:6f4d with SMTP id m9-20020a170902db0900b001887dca6f4dmr57232498plx.68.1669831209721;
        Wed, 30 Nov 2022 10:00:09 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:3729:bd90:53d2:99e3? ([2620:15c:211:201:3729:bd90:53d2:99e3])
        by smtp.gmail.com with ESMTPSA id z22-20020aa79596000000b0057294f480casm1733155pfj.97.2022.11.30.10.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 10:00:08 -0800 (PST)
Message-ID: <1d27a774-cf83-6e36-4fa1-c0635ebfd79e@acm.org>
Date:   Wed, 30 Nov 2022 10:00:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 2/2] RDMA/srp: Fix error return code in
 srp_parse_options()
Content-Language: en-US
To:     wangyufen <wangyufen@huawei.com>, jgg@ziepe.ca, leon@kernel.org,
        dennis.dalessandro@cornelisnetworks.com
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, bart.vanassche@wdc.com,
        easwar.hariharan@intel.com
References: <1669687459-14180-1-git-send-email-wangyufen@huawei.com>
 <1669687459-14180-2-git-send-email-wangyufen@huawei.com>
 <b4d78eb0-4492-ac7f-d500-3d49b0dc7aa1@acm.org>
 <65604aae-b722-4caf-3373-d0f1e4492faa@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <65604aae-b722-4caf-3373-d0f1e4492faa@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/29/22 19:31, wangyufen wrote:
> I'm so sorry for the poor patch description. Is the following 
> description OK?
> 
> In the previous iteration of the while loop, "ret" may have been 
> assigned a value of 0, so the error return code -EINVAL may have been 
> incorrectly set to 0.
> Also, investigate each case separately as Andy suggessted. If the help 
> function match_int() fails, the error code is returned, which is 
> different from the warning information printed before. If the parsing 
> result token is incorrect, "-EINVAL" is returned and the original 
> warning information is printed.

Please reply below instead of above. See also 
https://en.wikipedia.org/wiki/Posting_style.

Regarding your question: not logging an error message if user input is 
rejected is unfriendly to the user. I think it's better to keep the 
behavior of reporting an error if a match* function fails instead of 
reporting in the patch description that the behavior has changed.

Thanks,

Bart.

