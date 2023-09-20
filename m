Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF117A8A6F
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 19:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjITRSz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 13:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjITRSy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 13:18:54 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB870B4;
        Wed, 20 Sep 2023 10:18:48 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1d69c93954fso40330fac.0;
        Wed, 20 Sep 2023 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695230328; x=1695835128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sg2vWpczoEYs+/bxYrGrdl7eRPhM13SoFtWahG6f/fQ=;
        b=XSPZW3yJXJfoUqYqOTLABS9uQV6Sz7DoaE5Pit3J5z9y72gPHVz5zFQdGCRV6KRfYA
         RuuyCrCrnfgeLnDKyBuo3uGhaMnMkw56SRGZaP28u+Rv6+f6UYI0uspCgVSUHJBBA0EH
         wweBO9m9x6V1nzAJQiLi+6Y5dktEN94Vj3Bf8dZn7672dx2+xxPtaLgUWzYw3euz28kb
         uzdz8kBXFD2CzOicGKmEsbGAGwUttVatWbtsjY6TThEDnK2aGloYnHJ6q7L940ESlIgR
         +OJCerlxErepFUZFmt3SRjUiy8BRJ9kGgDk5e9aW3xn1lyrc6ZSUsI+neBGiynjWmGp/
         8XKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230328; x=1695835128;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sg2vWpczoEYs+/bxYrGrdl7eRPhM13SoFtWahG6f/fQ=;
        b=u3rdObiL5Xleuk0Nk3d5sUuMStv4qQ0uD3w3HHfxIo5L+Q3FsDw6sjcgSLRd2HNBdT
         8O8xQs7xoC6ZZt1CvYcd5Auc+J80WuuDw9RZWTS8B83LKE0Cpt6Q50y6uTH/6l7FPJan
         IVux4VWLkJpakZ7QV4/jgezMyVOeu8EqjqA7813rg/3jxoVAlku9MZrZHV7IiL43C8uY
         2WgBmpDX3rSDIuZLJUaQklhgseiNxu2LOdh5EQp9bh4fpGbqjJYa7wwBjRCmk58Ct4Bs
         NK6pOGn/NJTot+PMyu3gs9Y62cvAYpRxRiZ5fzYycd+KXVzQLsr20AqiJvmTLg9Y0XmG
         dLrw==
X-Gm-Message-State: AOJu0YxdyY07PVIXGUZUadunHAfm5NjV4/3WiC5PJ8mNFoDPMIzcpT3T
        Ok3Z4D4+U5E5zxgmKx5DYs0=
X-Google-Smtp-Source: AGHT+IGFb7L58awwALGn5JpOclNYCfDBDeIH2WriUDA8vetH+0xbXGd+d4JcPZBFaeAIKEj6v2EHAw==
X-Received: by 2002:a05:6870:9713:b0:1d0:dbdd:2792 with SMTP id n19-20020a056870971300b001d0dbdd2792mr3524498oaq.39.1695230328169;
        Wed, 20 Sep 2023 10:18:48 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:dc02:5dd1:9c21:a1b6? (2603-8081-1405-679b-dc02-5dd1-9c21-a1b6.res6.spectrum.com. [2603:8081:1405:679b:dc02:5dd1:9c21:a1b6])
        by smtp.gmail.com with ESMTPSA id tz4-20020a0568714a0400b001d666a1c076sm5917258oab.29.2023.09.20.10.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 10:18:47 -0700 (PDT)
Message-ID: <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
Date:   Wed, 20 Sep 2023 12:18:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Zhu Yanjun <yanjun.zhu@linux.dev>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <0c5c732c-283c-b29a-0ac2-c32211fc7e17@gmail.com>
 <yewvcfcketee5qduraajra2g37t2mpxdlmj7aqny3umf7mkavk@wsm5forumsou>
 <8be8f611-e413-9584-7c2e-2c1abf4147be@acm.org>
 <plrbpd5gg32uaferhjj6ibkt4wqybu3v3y32f4rlhvsruc7cu4@2pgrj2542da2>
 <18a3ae8c-145b-4c7f-a8f5-67840feeb98c@acm.org>
 <ab93655f-c187-fdab-6c67-3bfb2d9aa516@gmail.com>
 <9dd0aa0a-d696-a95b-095b-f54d6d31a6ab@linux.dev>
 <d3205633-0cd2-f87e-1c40-21b8172b6da3@linux.dev>
 <nqdsj764d7e56kxevcwnq6qoi6ptuu3bi6ntfakb55vm3toda7@eo3ffzzqrot7>
 <5a4efe6f-d8c6-84ce-377e-eb64bcad706c@linux.dev>
 <f50beb15-2cab-dfb9-3b58-ea66e7f114a6@gmail.com>
 <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev>
 <afc98035-1bb8-f75c-451a-8e3e39fb74aa@gmail.com>
 <6fc3b524-af7d-43ce-aa05-5c44ec850b9b@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <6fc3b524-af7d-43ce-aa05-5c44ec850b9b@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/20/23 11:36, Bart Van Assche wrote:
> On 9/20/23 09:24, Bob Pearson wrote:
>> The verbs APIs do not make real time commitments. If a ULP fails because of response times it is the problem in the ULP not in the verbs provider.
> 
> I think there is evidence that the root cause is in the RXE driver. I
> haven't seen any evidence that there would be any issues in any of the
> involved ULP drivers. Am I perhaps missing something?
> 
> Bart.

I agree it is definitely possible. But I have also seen the same behavior in the siw driver which is completely
independent. I have tried but have not been able to figure out what the ULPs are waiting for when the hangs
occur. If someone who has a good understanding of the ULPs could catch a hang and figure what is missing it
would give a clue as to what is going on.

As mentioned above at the moment Ubuntu is failing rarely. But it used to fail reliably (srp/002 about 75% of
the time and srp/011 about 99% of the time.) There haven't been any changes to rxe to explain this.

Bob

