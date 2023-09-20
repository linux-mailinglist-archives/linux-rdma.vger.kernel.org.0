Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258D47A8A7A
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 19:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjITRWv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 13:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjITRWu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 13:22:50 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45160B4;
        Wed, 20 Sep 2023 10:22:43 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1c3d8fb23d9so298565ad.0;
        Wed, 20 Sep 2023 10:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695230563; x=1695835363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bYUpaZYOt9TSUHkSBlm9DrJg3aIRvuXrIm9TUOCW25Y=;
        b=K9UEnkIvK7MUUOvpsdXO88QeZKoLzMYYKjgmKZ3f28SS5mFeT+YUS8E+T/ed6yHwk/
         aujNtHuSX+CPnDPNEeNR80KWedbr6ilLs4XCYtRH5nPX+6KEdWxgTUPbh/7zsmt8eeAC
         EoUZ3tQMMbfGNTdf6oykoA8B7RVNlv2xUIAhosI5J1RnNF5pbCSvZjJ9kZL4IiWDW4MY
         AilYDuj1M1bM4gKo50216GG2L9g1V0+U9l91LmBW7EmmlbEMEESr9kdgK+n5Ek7i6pWc
         HBSeaYY0gAl05yQUdVi9ULZqMjsUn4f2dhQAG7WRdTORUnEQqzvWMK7Xud9Bx28ReXOJ
         Uk+g==
X-Gm-Message-State: AOJu0YzZYfCdgzD4gUez04o3t6tIPEoB8edRXL7A4ogKH+QrXxwS3QCC
        Qwuy6ZHgloI6OVLm/z/frn0=
X-Google-Smtp-Source: AGHT+IHH3vsdcjZ2oPQybOhaJnpnykMqLM+dXiEyJinp9/0VBrB13d9bX5sLpMDjVKVKaJGwkU5s0Q==
X-Received: by 2002:a17:902:a714:b0:1c0:d5c6:748f with SMTP id w20-20020a170902a71400b001c0d5c6748fmr2517035plq.67.1695230562561;
        Wed, 20 Sep 2023 10:22:42 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:b0c6:e5b6:49ef:e0bd? ([2620:15c:211:201:b0c6:e5b6:49ef:e0bd])
        by smtp.gmail.com with ESMTPSA id x11-20020a170902ec8b00b001befac3b3cbsm10514293plg.290.2023.09.20.10.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 10:22:42 -0700 (PDT)
Message-ID: <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org>
Date:   Wed, 20 Sep 2023 10:22:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Bob Pearson <rpearsonhpe@gmail.com>,
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/20/23 10:18, Bob Pearson wrote:
> But I have also seen the same behavior in the siw driver which is
> completely independent.

Hmm ... I haven't seen any hangs yet with the siw driver.

> As mentioned above at the moment Ubuntu is failing rarely. But it 
> used to fail reliably (srp/002 about 75% of the time and srp/011 
> about 99% of the time.) There haven't been any changes to rxe to 
> explain this.

I think that Zhu mentioned commit 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue
support for rxe tasks")?

Thanks,

Bart.
