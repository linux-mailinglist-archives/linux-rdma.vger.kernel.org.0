Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2F37CC9A1
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Oct 2023 19:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjJQRPK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Oct 2023 13:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjJQRPF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Oct 2023 13:15:05 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE311B0;
        Tue, 17 Oct 2023 10:15:03 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6c64a3c4912so4129266a34.3;
        Tue, 17 Oct 2023 10:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697562903; x=1698167703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8acLeLlRrLYp9mCpL+tf31hSrqS4sswiW1N3QSh5bM8=;
        b=On/QN1puD+jmJLQZ2qCzKrmETym50Myq6xPlTF0Ku2ErcI9uTeyQ7UohHs/5C81q2m
         g+jS3w7n+mK8eVoCpRBzdG5qd1i37ENEZ3vvTKL6p3vblF0wy/3N/nx1LCXwrhn7/k2K
         uRZkpMRpCH87gieRpC7etA3lxIMZphmQXllhoLcpvEPeoToSwEbDZUtAO53dkKqbUjtf
         KIBJXiQ5lrdmT9wgggu9WiqiRZSsT+xloJ1lOZb5mX9E4of7B46ytsou9CfLa4Hz5t/e
         PfZxxMA6Gr0OC0mr4ipVlMxD2QiLiWNCE7yjIIFc7kaeeRgFtvocre73drynArYUPfTO
         EgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697562903; x=1698167703;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8acLeLlRrLYp9mCpL+tf31hSrqS4sswiW1N3QSh5bM8=;
        b=GEPl35BTW/+F5UNEz/Mfl41kLf+hvCC/RB310Y7TT97GD2qdtD/oSzdhaeX4RsYg7G
         Mq8Awr33Sg+wa4JgoVgM3XA72DZ+ikWd/YzRzS7qpxCuRS+vTf2FU4Yo2tnLU3qoo7jS
         XYEzTo5UhNI3Ap5D5hQP5MffqZwUTZgFOEKran4dlTaMZcKafSU0hDlwTpRBWQ89fUDm
         J7rakz/kIsdHlDnBEwm66azaGamTBuUEL+VfSkX8iPD5jmbDbhdSvOSea2jcjzBezm9R
         2B+EU+e1cIt4D6i+slCI6KEfkDoMt6Q/yj/xt+NvZBct1jp8OrWpfOGLVCLGoK1wB4A/
         Po4g==
X-Gm-Message-State: AOJu0YxRZr8PtJ1F4Lec/oUS14/Q8TiNsdMHXcptaJ3cX7rtn3DHO/5p
        fe/QsGk9ekuYPYMQeKyAk7I=
X-Google-Smtp-Source: AGHT+IFrytCFNlYtF1ivi1bfh2nggibVE4GQ26z7UQ8TRlH8PD2n5ifiYEMq2s+dg1E4WRioevqI4A==
X-Received: by 2002:a05:6870:d629:b0:1ea:2d32:d8cd with SMTP id a41-20020a056870d62900b001ea2d32d8cdmr3626467oaq.42.1697562903098;
        Tue, 17 Oct 2023 10:15:03 -0700 (PDT)
Received: from ?IPV6:2603:8081:1405:679b:4a90:522a:952e:515c? (2603-8081-1405-679b-4a90-522a-952e-515c.res6.spectrum.com. [2603:8081:1405:679b:4a90:522a:952e:515c])
        by smtp.gmail.com with ESMTPSA id dy22-20020a056870c79600b001e1754b9fc1sm330786oab.24.2023.10.17.10.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 10:15:02 -0700 (PDT)
Message-ID: <4e85365e-42b5-4a33-b32e-5453fb219af6@gmail.com>
Date:   Tue, 17 Oct 2023 12:15:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] blktests srp/002 hang
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        "Daisuke Matsuda (Fujitsu)" <matsuda-daisuke@fujitsu.com>,
        'Rain River' <rain.1986.08.12@gmail.com>
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
        "leon@kernel.org" <leon@kernel.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <dsg6rd66tyiei32zaxs6ddv5ebefr5vtxjwz6d2ewqrcwisogl@ge7jzan7dg5u>
 <fe61fdc5-ca8f-2efc-975d-46b99d66c6f5@linux.dev>
 <afc98035-1bb8-f75c-451a-8e3e39fb74aa@gmail.com>
 <6fc3b524-af7d-43ce-aa05-5c44ec850b9b@acm.org>
 <b728f4db-bafa-dd0f-e288-7e3f56e6eae8@gmail.com>
 <02d7cbf2-b17b-488a-b6e9-ebb728b51c94@acm.org>
 <b80dae29-3a7c-f039-bc35-08c6e9f91197@gmail.com>
 <CAJr_XRAy4EHueAP-10=WSEa46j2aQBArdzYsq7OqSqR93Ue+ug@mail.gmail.com>
 <8aff9124-85c0-8e3b-dc35-1017b1540037@gmail.com>
 <3c84da83-cdbb-3326-b3f0-b2dee5f014e0@linux.dev>
 <4e7aac82-f006-aaa7-6769-d1c9691a0cec@gmail.com>
 <CAJr_XRCFuv_XO3Zk+pfq6C73CgDsnaJT4-G-jq1ds3bdg76iEA@mail.gmail.com>
 <OS7PR01MB1180450455E624D5CD977C461E5FCA@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <29c5de53-cc61-4efc-8e8d-690e27756a16@acm.org>
 <OS7PR01MB118045AD711E93D223DCD6F17E5C3A@OS7PR01MB11804.jpnprd01.prod.outlook.com>
 <a3be5e98-e783-4108-a690-acc8a5cc5981@gmail.com>
 <fb4fae79-59a4-4fe2-93ab-24232ddbd784@acm.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <fb4fae79-59a4-4fe2-93ab-24232ddbd784@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/17/23 12:13, Bart Van Assche wrote:
> 
> On 10/17/23 10:09, Bob Pearson wrote:
>> I don't yet understand the logic of the srp driver to fix this but
>> the problem is not in the rxe driver as far as I can tell.
> Is there any information available that supports this conclusion? I
> think the KASAN output that I shared shows that there is an issue in
> the RXE driver.
> 
> Thanks,
> 
> Bart.
> 

Bart,

I have seen 100's of hangs. I have never seen a KASAN warning and it is configured in my kernel.

Bopb
