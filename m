Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7639B7A8A9D
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 19:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjITR3o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 13:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjITR3n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 13:29:43 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC787CA;
        Wed, 20 Sep 2023 10:29:37 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1bba7717d3bso35961fac.1;
        Wed, 20 Sep 2023 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695230977; x=1695835777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cw0wwV+AWxUAaPBPNrxXNrrjadB4Sp+CqjdBtpMka38=;
        b=lQ0qqpt5Mm0ZYW1nPGjuT+d2tzy672JXn3yUeJUGDmVVg9IIk85FfN9Lrj/XIR5foS
         abu6jX06zHcpRELQHCX9P7IE25L9iq0+wA+R4hOfwvhAkT+QoPJAbR48FCellyrUKze8
         IyUQ1GIjeZx/b9XT54gSQmOcKCidmlYqGb+WBOvRVwAdXmtp7cd3hw8M+37WF+JlnL/u
         6Rho/JD/CMWxnMcrA8vKHs23mxl2lcAuPN1r4dcoV4sVdWXsF92UldmVLcnRqSIbQeOR
         Asl/soQ9zXlIfGV51YjZkDf+1JJxd0YTCM4ihL40gZXwLm5WdryciKfPpBpslRVcwr4c
         iJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230977; x=1695835777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cw0wwV+AWxUAaPBPNrxXNrrjadB4Sp+CqjdBtpMka38=;
        b=IrdGWHOPyDbFBAiuSyEUKscOiIyK2ZD50cf+fEd3d1E10YCwqcOj7jBHWt2bjKoQSN
         ehA3Gx7RcclW7jCRNwv6rh/HkMG2rO4AnjLq6C6DB48Ln/P9liq4CWz+brPPNK4jKZqu
         5HeS8PkzYPb97peGT10xZycfIzZHHTa4m5p32RJnue8dKluncFcD2WfgpSZ38HOi0Ibl
         egxYXJHcWpnN4jona7odibClv11sFpxSB1V0UE+XyDJIbrLstz/a6UifEMa7JjG4D0YZ
         RXZr0Oeazthh7LJXUqrYibckuk+1lILMP3g/FLzk84/TLNeZoVLb0eE0wpyqs3JUdSRB
         kvVw==
X-Gm-Message-State: AOJu0Yw8fvM28/w89xylhfg8qArs9W/QGnVDDf4AAEOAMKWni5hHWAV3
        sw+SL7/v8KSFoNw/lBiTmZdnhZBIcZ8=
X-Google-Smtp-Source: AGHT+IFITLjcwqYSu9G9nUVkg60eHr1uVAChDjtJXP76bklwSYNIrxw/PlzOryLNKzrrRpg96rOAPQ==
X-Received: by 2002:a05:6870:14d5:b0:1d1:425b:802d with SMTP id l21-20020a05687014d500b001d1425b802dmr3807680oab.7.1695230976776;
        Wed, 20 Sep 2023 10:29:36 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:dc02:5dd1:9c21:a1b6? (2603-8081-1405-679b-dc02-5dd1-9c21-a1b6.res6.spectrum.com. [2603:8081:1405:679b:dc02:5dd1:9c21:a1b6])
        by smtp.gmail.com with ESMTPSA id eg50-20020a05687098b200b001db36673d92sm2743912oab.41.2023.09.20.10.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 10:29:36 -0700 (PDT)
Message-ID: <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
Date:   Wed, 20 Sep 2023 12:29:35 -0500
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
 <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
 <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/20/23 12:22, Bart Van Assche wrote:
> On 9/20/23 10:18, Bob Pearson wrote:
>> But I have also seen the same behavior in the siw driver which is
>> completely independent.
> 
> Hmm ... I haven't seen any hangs yet with the siw driver.

I was on Ubuntu 6-9 months ago. Currently I don't see hangs on either.
> 
>> As mentioned above at the moment Ubuntu is failing rarely. But it used to fail reliably (srp/002 about 75% of the time and srp/011 about 99% of the time.) There haven't been any changes to rxe to explain this.
> 
> I think that Zhu mentioned commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue
> support for rxe tasks")?

That change happened well before the failures went away. I was seeing failures at the same rate with tasklets
and wqs. But after updating Ubuntu and the kernel at some point they all went away.

> 
> Thanks,
> 
> Bart.


