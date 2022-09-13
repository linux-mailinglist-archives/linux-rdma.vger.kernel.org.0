Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7214C5B7D14
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Sep 2022 00:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiIMWbN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Sep 2022 18:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiIMWbM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Sep 2022 18:31:12 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A1861723
        for <linux-rdma@vger.kernel.org>; Tue, 13 Sep 2022 15:31:06 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11e9a7135easo36133993fac.6
        for <linux-rdma@vger.kernel.org>; Tue, 13 Sep 2022 15:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=P6/+eey78DVr9qKN+MbyuMuBy153UbJh8mtNGJKWYNU=;
        b=iTkQgoOjN6d1U4JNGgIadexYC/lZ5TeUG7Y5VBIw3OfwhPXN0YQuxCJBCODkD11u4p
         4teadlHrxxsSW7aGhuoZtMzbeEDWs3V2VKDtEWDCdkiNc5oo+aMeWreZNIiwkNl+NXxY
         M6hmYd1aGmln48w/g4lM63h2FPiNMiSCuAIIgvl+sO1g4yRzKQWReJ6xUjZ0vzL5amqn
         s7Z9ydiaClvyCnPSkzx9EfGQhHSuLV548jMUIMyRUn2cAzLt62TjweJH21qQa1gJ1HPf
         SQDP589SXi1EY9d3rvAraDWeZ5hcFOYQ/CqLmsN2CzRrW+frYRBsLR1bzeMWpf6+VTbL
         W04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=P6/+eey78DVr9qKN+MbyuMuBy153UbJh8mtNGJKWYNU=;
        b=3jLt7QNSSlvBPpj9M8wpyH4XH3m1fro23SfpQOMgrw1U+us0r7/hHrgPZoox+P0fco
         mHnO8G+TaffY18QqqSHFgncaxRDju138tE7FfPKFYGBSpQxI9GWgDr/PCxCyLZJUxzfS
         vHBekC1oWyDm1h2Q/0hyayAuEFfgZrNFeqfW6o7XoxYsXcR4S75rUhHfIgfsPjZ++YDP
         JwxC/SuuP1qoBfOlOfVjbV90AnoPsqyhPmnoLo8UyQS9Ibbu1Mgqta79bPJvKHzEV+yF
         xZcc1pSNGo8sOCNgN103P/61J+CFVCAAxxX7QlfuemLeFvLO8bvrL1+TyV/tPlrb0lMt
         ebSw==
X-Gm-Message-State: ACgBeo3Tlgo/aZo7mEN1iK+hMCpARD/xulT5ZO2ZxQMJ0FqTw8hkEQ1Y
        QASqvQamlewgX/9t8qjVwX0ECiI2M4Q=
X-Google-Smtp-Source: AA6agR5m39WgKOZOkFegGbnCZ470whViCF0lBDxWP/cpwAEHitbuEYqVrnkVM2+akvoxSzxIJV5Zsw==
X-Received: by 2002:a05:6870:8289:b0:127:d302:66f8 with SMTP id q9-20020a056870828900b00127d30266f8mr766581oae.16.1663108265695;
        Tue, 13 Sep 2022 15:31:05 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-d098-9475-e37c-b40b.res6.spectrum.com. [2603:8081:140c:1a00:d098:9475:e37c:b40b])
        by smtp.googlemail.com with ESMTPSA id v17-20020a05683018d100b0063696cbb6bdsm6537131ote.62.2022.09.13.15.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 15:31:04 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 0/2] providers/rxe: Remove redundant num_sge_fields
Date:   Tue, 13 Sep 2022 17:30:49 -0500
Message-Id: <20220913223050.18416-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

This patch series removes two unused num_sge fields in
struct rxe_send_wr and struct rxe_recv_wqe in favor of the
num_sge field in struct rxe_dma_info. It has no effect on the
current ABI. It has the desireable side effect of freeing
4 bytes in rxe_send_wr, which is otherwise completely full, for
other uses.

Bob Pearson (2):
  Update kernel headers
  providers/rxe: Remove redundant num_sge fields

 kernel-headers/rdma/rdma_user_rxe.h |  4 ++--
 providers/rxe/rxe.c                 | 11 +++++------
 2 files changed, 7 insertions(+), 8 deletions(-)


base-commit: 3cbfb618e0a70d7341d1e737fd00f661ccaac1c4
-- 
2.34.1

