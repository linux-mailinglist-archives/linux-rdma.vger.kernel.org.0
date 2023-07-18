Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957CE757197
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Jul 2023 04:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjGRCIN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Jul 2023 22:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGRCIM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Jul 2023 22:08:12 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4B810C2
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jul 2023 19:08:06 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a43cbb432aso3001775b6e.3
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jul 2023 19:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689646085; x=1692238085;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=383/VbA0XtQXqdv/CAq9bkUghmjtAta7csVGBEOsEZ8=;
        b=Z0UNmuta+tBfXNIUJryHxO6VwcsHFkbr42QDaB0TxZm5E0kceU93qxDCG+8AKVIEiV
         pLTw0dpULyboTyxWVkLlgmi4LgcMySOYOBHMkLxbB91lwTOGckQRLkSAmbVzFrKZ2GTn
         Q1FdpG1M+gQrf3XIQTK76+RoWtz/txSzdbFFBUyeFAv5ZFbCO4RWD76xMNJQ54iYJsAV
         LtQE15UdbHa+JOIk2qW1W9B6WVgprl3aJJk5l1hlgJUaUQlvf6aFxgosUIIqhtmaXMA7
         R1QBbu9b1oBgsqQn3px1xfMCfEdpQlVWByYcu9Ho4TroLcqrofh+g654y0O2wtN66xxR
         DdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689646085; x=1692238085;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=383/VbA0XtQXqdv/CAq9bkUghmjtAta7csVGBEOsEZ8=;
        b=bHmQpgDucBYq901MDzUqj8qPmuztOGayZHNSpfeZL9Xp3KxyJUv220tMq4tv/j3pPN
         Ksvu//AOrDnNLKgzvGVb3DAVsI9seE5kAKMAL3/Bct9r2qnLOqkj3W5ak8qLsNwWyBlF
         +V0zWd8qG3N8phnZ9iWlKZowKwixsBYbFmam4/0LwMC6+ZPVLksuoGH9vKl48wWAL4of
         qrvwQfkVRmLwoVldZUvN1CPoJG6rYoddk1eLPGmOIaZhwWF1Ry03IdyUTLTYyFxbYyjs
         538dVJsYLG8kgQvlWOo5KuOHMYTG6beB9Jql97RWcd67379xLzC501nGFlR7ZJ2XAeZR
         QbnQ==
X-Gm-Message-State: ABy/qLbTMV6lpVEStPfHZ6yMKeLpYN3lzAyotUB08BoFl6mvJOTmwQp2
        u2o0orQBa/BwHesw3/MWECdofG2HIPI=
X-Google-Smtp-Source: APBJJlGiFooqSzmIkSs10jT8twqR1SsWdsWT7pkmWolG6SCgBHchZFuEEM+IGGO0N+HZUa3viwBTvw==
X-Received: by 2002:a05:6808:1491:b0:3a3:c1af:e097 with SMTP id e17-20020a056808149100b003a3c1afe097mr16019041oiw.28.1689646084580;
        Mon, 17 Jul 2023 19:08:04 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:2f8:ff69:16db:1c31? (2603-8081-140c-1a00-02f8-ff69-16db-1c31.res6.spectrum.com. [2603:8081:140c:1a00:2f8:ff69:16db:1c31])
        by smtp.gmail.com with ESMTPSA id bq19-20020a05680823d300b003a4243d034dsm337395oib.17.2023.07.17.19.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 19:08:04 -0700 (PDT)
Message-ID: <a958a957-dfe3-9348-632f-ee0c9af13238@gmail.com>
Date:   Mon, 17 Jul 2023 21:08:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fwd: pyverbs test_resize_cq fails in some cases
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     linux-rdma@vger.kernel.org, Edward Srouji <edwards@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <f218337a-b975-bfa7-635d-bafc42c2df04@gmail.com>
 <b43c8172-a1c3-2ebd-e70e-198ae68248b5@gmail.com>
In-Reply-To: <b43c8172-a1c3-2ebd-e70e-198ae68248b5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/23/23 21:38, Bob Pearson wrote:
> 
> 
> 
> -------- Forwarded Message --------
> Subject: pyverbs test_resize_cq fails in some cases
> Date: Thu, 23 Mar 2023 21:37:28 -0500
> From: Bob Pearson <rpearsonhpe@gmail.com>
> To: Edward Srouji <edwards@nvidia.com>
> CC: Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
> 
> Edward,
> 
> The pyverbs test: test_resize_cq fails for the rxe driver in some cases.
> 
> The code is definitely racy:
> 
> def test_resize_cq(self):
>         """
>         Test resize CQ, start with specific value and then increase and decrease
>         the CQ size. The test also check bad flow of decrease the CQ size when
>         there are more completions on it than the new value.
>         """
>         self.create_players(CQUDResources, cq_depth=3)
>         # Decrease the CQ size.
>         new_cq_size = 1
>         try:
>             self.client.cq.resize(new_cq_size)
>         except PyverbsRDMAError as ex:
>             if ex.error_code == errno.EOPNOTSUPP:
>                 raise unittest.SkipTest('Resize CQ is not supported')
>             raise ex
>         self.assertTrue(self.client.cq.cqe >= new_cq_size,
>                         f'The actual CQ size ({self.client.cq.cqe}) is less '
>                         'than guaranteed ({new_cq_size})')
> 
>         # Increase the CQ size.
>         new_cq_size = 7
>         self.client.cq.resize(new_cq_size)
>         self.assertTrue(self.client.cq.cqe >= new_cq_size,
>                         f'The actual CQ size ({self.client.cq.cqe}) is less '
>                         'than guaranteed ({new_cq_size})')
> 
>         # Fill the CQ entries except one for avoid cq_overrun warnings.
>         send_wr, _ = u.get_send_elements(self.client, False)
>         ah_client = u.get_global_ah(self.client, self.gid_index, self.ib_port)
>         for i in range(self.client.cq.cqe - 1):
>             u.send(self.client, send_wr, ah=ah_client)
> 
> 	### This posts 6 send work requests but does not wait for them to complete
> 	### The following proceeds while the sends are executing in the background
> 	### and the test can fail. An easy fix is to add the line
>         time.sleep(1/1000)  ### or maybe something a little larger but this works for me.
> 	### alternatively you could test the data at the destination.
> 
>         # Decrease the CQ size to less than the CQ unpolled entries.
>         new_cq_size = 1
>         with self.assertRaises(PyverbsRDMAError) as ex:
>             self.client.cq.resize(new_cq_size)
>         self.assertEqual(ex.exception.error_code, errno.EINVAL)
> 
> Bob

Edward,

This is showing up again. The software drivers are slower than the hardware drivers.
Now that the send side logic in the rxe driver is handled by a workqueue and if it is
scheduled instead of running inline this test will fail some percentage of the time.
Especially when the test is run for the first time but 5-10% of the time after that.
If you run the send side logic inline it is fast enough that the test doesn't fail but
that doesn't allow the workqueue tasks to spread out on the available cores so for high
QP count it is much better to schedule them.

There are a few time.sleep(1) calls in the pyverbs test suite but that is wasteful and
better is time.sleep(0.001) which works fine for this test and doesn't slow down the
run time for the whole suite noticeably.

Bottom line this test case is racy.

If you want I can submit a 2 line patch that does this. Or if you would that would be
better.

Bob
