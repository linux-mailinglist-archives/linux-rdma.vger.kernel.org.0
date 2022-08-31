Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761535A74A7
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Aug 2022 06:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiHaEEw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Aug 2022 00:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiHaEEw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 Aug 2022 00:04:52 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A0FE05;
        Tue, 30 Aug 2022 21:04:51 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id q63so12452509pga.9;
        Tue, 30 Aug 2022 21:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Ugy18ngp8TGo8D4YXWwazm/ISYgDkRHB79Dqf1WUU1E=;
        b=M1p1G/l9omHGz7+ZYzWGcQe09vJ+q0Xm8uTcUW0CBhjcogr7KUbjsSb+/QQaHwzgJN
         oND36CdAyR1/vQO86AdcWW6xuNOTwjdQRjB5i9ap7YaiX/g1esispDLT6nDWBr6mQSWf
         ZeWayjdF4kcvpIjOOxWYj+19t0WMva53pbhvf87QJwm5NtM/zMgbNBRun5zbOAvl85Wh
         uKkoeaNXMbp9jIXlrZUa8v4jvAWTOGAI/WV1Qep9Eakm5pkXoWJPVs4fHzMg/npgeqY0
         QJ8LHygTzC4kdtyHgHSnh7mZb94x5V691lLIqT0u+30+8SjgmBBjY82g8RMWqghMuD7x
         8z4w==
X-Gm-Message-State: ACgBeo1hILgJuL6fT6ctMWwSBQygiSeSySBjskJCoSFF4FW42qtZD5hK
        nQkD28z+0UJbqt0x8IZEipk=
X-Google-Smtp-Source: AA6agR6w+lV3se8EUuvDlebbruOsx7Yf3qQA+5w1OqLzOgB2LQx/vGe5qmKXrAAZgOyUlc07yXPr+w==
X-Received: by 2002:a65:6b8a:0:b0:42b:1eca:eef1 with SMTP id d10-20020a656b8a000000b0042b1ecaeef1mr20193646pgw.205.1661918690353;
        Tue, 30 Aug 2022 21:04:50 -0700 (PDT)
Received: from [172.20.0.236] ([12.219.165.6])
        by smtp.gmail.com with ESMTPSA id s15-20020a170902ea0f00b0015e8d4eb1f7sm10348441plg.65.2022.08.30.21.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 21:04:49 -0700 (PDT)
Message-ID: <ca74a481-3e80-9a7a-9db7-d766a16d8fd6@acm.org>
Date:   Tue, 30 Aug 2022 21:04:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/srp: Set scmnd->result only when scmnd is not NULL
Content-Language: en-US
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220831014730.17566-1-yangx.jy@fujitsu.com>
 <5daac9db-2b34-fbe5-a891-8ecf77fbe46f@acm.org>
 <bff7565b-7159-e8f4-e8f5-711994f95056@fujitsu.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <bff7565b-7159-e8f4-e8f5-711994f95056@fujitsu.com>
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

On 8/30/22 20:16, yangx.jy@fujitsu.com wrote:
> Sorry, I didn't make the right fix. I will send v2 patch.
> I think scmnd may be set to NULL after srp_claim_req() is called and
> then setting scmnd->result can trigger the NULL pointer dereference.

Something like this untested patch may be what you are looking for:

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c 
b/drivers/infiniband/ulp/srp/ib_srp.c
index 7720ea270ed8..d7f69e593a63 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1961,7 +1961,8 @@ static void srp_process_rsp(struct srp_rdma_ch 
*ch, struct srp_rsp *rsp)
  		if (scmnd) {
  			req = scsi_cmd_priv(scmnd);
  			scmnd = srp_claim_req(ch, req, NULL, scmnd);
-		} else {
+		}
+		if (!scmnd) {
  			shost_printk(KERN_ERR, target->scsi_host,
  				     "Null scmnd for RSP w/tag %#016llx received on ch %td / QP 
%#x\n",
  				     rsp->tag, ch - target->ch, ch->qp->qp_num);

Bart.
