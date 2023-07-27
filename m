Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E956B765B3F
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jul 2023 20:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjG0SPe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jul 2023 14:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjG0SPd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jul 2023 14:15:33 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242FA2D64
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 11:15:33 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1bbc06f830aso8297015ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jul 2023 11:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690481732; x=1691086532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMQe+7msaGAZX7g4xNJfoDVlBeiDDwObqqwZe9hgZUs=;
        b=akTBCrSunVkPpFUKkK87auCLxdRP/8niwO7NWyw2MV1vHA9NhhV9cu4oc91l8szfCx
         pH/xIU186uZgcEicX9pdm4Eh6nGZTKZx6povpcoFcOHxTOa6gaJrVIF6+DWkGGaf+r99
         bcS9v7VDBx5WEkZwcSm/RzaUF5s+h/U7aKuJUuXjpVfPGcDlDMlCpKNBxkgjoT6+GGfM
         F65+vqfNwlxUjviTz4zhNePWeynlEMKkSIoL0djoYImTg7RecBBcE8xt+k8S9P3MtcQ1
         Nw/02mhUFtWQuZ2rhKLsGdNHWBszLKjhUCzKsXsiBKM/saP/h+0r6jj0lXBh5AEP1aEQ
         htGw==
X-Gm-Message-State: ABy/qLbVa5Zvp4/Ir/hMKTlbpRKbGotWjBOKQ2+uIorOXT6KTGxvWxi3
        PXzLK9qwHwMbZYEs2fKEePM=
X-Google-Smtp-Source: APBJJlFJ9LTnNwQFMU34SgAgaZ3tG+K4EMKVQcStA1c+gIbp76DGTQPc/4KzceA+8K7VV4DhRmzt8w==
X-Received: by 2002:a17:902:da91:b0:1bb:c9e3:6d4f with SMTP id j17-20020a170902da9100b001bbc9e36d4fmr77008plx.10.1690481732324;
        Thu, 27 Jul 2023 11:15:32 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:32d2:d535:b137:7ba3? ([2620:15c:211:201:32d2:d535:b137:7ba3])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902ee4600b001b9c5e07bc3sm1944143plo.238.2023.07.27.11.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 11:15:31 -0700 (PDT)
Message-ID: <7a43c318-0e59-3de2-d686-f509be692c22@acm.org>
Date:   Thu, 27 Jul 2023 11:15:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/5] Fix potential issues for siw
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20230727140349.25369-1-guoqing.jiang@linux.dev>
 <SN7PR15MB575506FAF5423F726708AF8F9901A@SN7PR15MB5755.namprd15.prod.outlook.com>
 <ZMKpcQsJ3FBvxYHo@ziepe.ca>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZMKpcQsJ3FBvxYHo@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/27/23 10:29, Jason Gunthorpe wrote:
> On Thu, Jul 27, 2023 at 05:17:40PM +0000, Bernard Metzler wrote:
>> very good catch, thank you. I was under the wrong assumption a
>> module is not loaded if the init_module() returns a value.
> 
> I think that is actually true, isn't it? I'm confused?

My understanding is also that module loading should fail if 
init_module() returns an error code. From kernel/module/main.c:

	/* Start the module */
	if (mod->init != NULL)
		ret = do_one_initcall(mod->init);
	if (ret < 0) {
		goto fail_free_freeinit;
	}
	if (ret > 0) {
		pr_warn("%s: '%s'->init suspiciously returned %d, it "
			"should follow 0/-E convention\n"
			"%s: loading module anyway...\n",
			__func__, mod->name, ret, __func__);
		dump_stack();
	}

Bart.
