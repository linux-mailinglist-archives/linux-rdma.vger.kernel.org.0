Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FDE7100DF
	for <lists+linux-rdma@lfdr.de>; Thu, 25 May 2023 00:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbjEXWYZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 May 2023 18:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbjEXWYH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 May 2023 18:24:07 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EC01984
        for <linux-rdma@vger.kernel.org>; Wed, 24 May 2023 15:23:27 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-19a2d231ef1so603913fac.2
        for <linux-rdma@vger.kernel.org>; Wed, 24 May 2023 15:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684966923; x=1687558923;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9a8cagkE9Thgkdu8bZ1C1uZP8YCPu5p3Mocap1zDWA=;
        b=pC59m/oXgXFs7HINwL6a1gnP9i343IrCAtI51PXeEPlklz0NI3H/9R9K9RPHAt9k4Z
         RGp5+THfNti5KEWyI4aTPKubrqYQbtX3mUGBCWurF+qy7du3/lwY90ZuxMAHFZQxtOdo
         u/qWEzVEXMYCbfHKiLiJn/LDUNcu8MhxVb+ubFTmamFHRXZV7SSMZj8Ma7DClqxNh9jI
         NpWweCCtGItk5xPogoYB/25qTenL40RBZ3kz17cHgjuCSAWZpvxuAdcuLFpK8rKcbyed
         NBQVqL02oZOF/5wPisgRcVocr18T/PHloyv2Luew8NnIJMqjEkUv1t90fShlXM47LUYu
         TE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966923; x=1687558923;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d9a8cagkE9Thgkdu8bZ1C1uZP8YCPu5p3Mocap1zDWA=;
        b=jCjvi7Fm1Kyz4OpDKfkCopMyArYbNu56r+xTpmJiYJWURPpuO20S2AGWKUAN6XSdG1
         dJLGfLxE0QKRm8O6YxKT9Pp9WySoHZ2TueTqs2DyPuBcDIR4dgnErWleFi0n38W4tmAt
         gx7Nfw1xySfGzxaLZpuW6k3epffbbUY0n87+LEzm1ufPDuCEV6jkXCcT8FNJaVRpTWsY
         RdP6FRmNP5BvnG29/52Gfw0KPrsT3AdMbujCOcWi5+A7rfCiUUbQbM4gto2djkDStb3u
         Hih0MTgagsuoDIOV0itz/QKPI6Y6g6g+sBx2I2Gzs7ZyneI44++QagtdvI1ELVQXxxEN
         /itw==
X-Gm-Message-State: AC+VfDxMosR9g7sQAilGustQ6zcByAj9k4iQqSgQBLBhYzxkGQNEMCll
        xhwCmpzgsTZCg0bmoM2EIQJDl7xJjeqrlA==
X-Google-Smtp-Source: ACHHUZ7GJOGOYui3NiucKjZW8HGZvbeipVs1jVTrsUCrkARkEvC9i91OX3mTMMGc0zSrpwwmrisbow==
X-Received: by 2002:a05:6870:93d3:b0:187:8a98:10b3 with SMTP id c19-20020a05687093d300b001878a9810b3mr636222oal.45.1684966923087;
        Wed, 24 May 2023 15:22:03 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e32a:8417:bb00:f8d7? (2603-8081-140c-1a00-e32a-8417-bb00-f8d7.res6.spectrum.com. [2603:8081:140c:1a00:e32a:8417:bb00:f8d7])
        by smtp.gmail.com with ESMTPSA id t7-20020a9d7747000000b006a42e87aee4sm16367otl.32.2023.05.24.15.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 15:22:02 -0700 (PDT)
Message-ID: <12981460-88f4-017e-be8e-f19d1dee142f@gmail.com>
Date:   Wed, 24 May 2023 17:22:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Edward Srouji <edwards@nvidia.com>,
        ido Kalir <idok@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: problems with test_mr_rereg_pd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Edward, Ido,

The test_mr_rereg_pd pyverbs test is failing for the rxe driver.
I have figured out that the problem is that the following sequence

    def test_mr_rereg_pd(self):
        """
        Test that cover rereg MR's PD with this flow:
        Use MR with QP that was created with the same PD. Then rereg the MR's PD
        and use the MR with the same QP, expect the traffic to fail with "remote
        operation error". Restate the QP from ERR state, rereg the MR back
        to its previous PD and use it again with the QP, verify that it now
        succeeds.
        """
        self.create_players(MRRes)
        u.traffic(**self.traffic_args)
        server_new_pd = PD(self.server.ctx)
        self.server.rereg_mr(flags=e.IBV_REREG_MR_CHANGE_PD, pd=server_new_pd)
        with self.assertRaisesRegex(PyverbsRDMAError, 'Remote operation error'):
            u.traffic(**self.traffic_args)
        self.restate_qps()
        self.server.rereg_mr(flags=e.IBV_REREG_MR_CHANGE_PD, pd=self.server.pd)
        u.traffic(**self.traffic_args)
        # Rereg the MR again with the new PD to cover
        # destroying a PD with a re-registered MR.
        self.server.rereg_mr(flags=e.IBV_REREG_MR_CHANGE_PD, pd=server_new_pd)

Schedules 10 iterations of a UD send to UD receive with an invalid mr pd which does not
match the qp pd. So it fails with a remote operation error on the first request.
The remaining 9 send and receive work requests are flushed to the caller with a
FLUSH_ERROR but not cleared out of the completion queues.

This is required by the IBA for Class A responder errors ("Remote operational error").
In C9-220 it requires:

      All other WQEs on both queues, and all WQEs subse-
      quently posted to either Queue, are completed with
      the “Completed - Flushed in Error” status

The final phase of the test wants to verify that after putting the original pd
back into the mr traffic works OK. But the remaining FLUSH errors in the completion
queues cause the test to fail.

To make this test work you would have to clean the completion queues as part of
restate_qps but that is not done.

Bob
