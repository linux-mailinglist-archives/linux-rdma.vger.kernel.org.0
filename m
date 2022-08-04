Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A7A58A3F1
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 01:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbiHDXhY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 Aug 2022 19:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239940AbiHDXhX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 Aug 2022 19:37:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3DC6E8B3
        for <linux-rdma@vger.kernel.org>; Thu,  4 Aug 2022 16:37:22 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v3so1511428wrp.0
        for <linux-rdma@vger.kernel.org>; Thu, 04 Aug 2022 16:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=YeEFrOpnueqp49lpSsCtkyhW66cD5QzqZPU5hyS5TkM=;
        b=bo2XBP67BuG05EPFv/XoJIdVEPLxa1771zsCCTAejlB5sRGBBJscipwNLbZSExpHaj
         pUyKO8j/8PL7bynEnTgIAfFfO5K7kE8SGUNCahnQkTvPNNs2NqPrlMjL+jGU6tqcn8Rr
         A/uSn/rVR5Iu09uC/vIuAEyZWqqBuJmPhdgTDpmQg7LcGzOoKz8YVbV26QOS7ffG0IIx
         8/fXPOKXG6S+ehx0Nsw5fiMFEQ4CGeFzBxo5ytpgvK6OynC4YtnkE0s+TZRo5vzbvQqY
         zpBeWRiCfpL0Ol54u9tRq0gBY0fHGFZvmHpIN8HBVco2JTUPEFgHVWy3oXKtNjGfnyiJ
         KxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=YeEFrOpnueqp49lpSsCtkyhW66cD5QzqZPU5hyS5TkM=;
        b=7diD6TDyxOem4XXCW3MTjGFyxQK4o7npU3edUvmeE1HhqXDFvYbQQexNjuUvG+v9mZ
         yQHAsZNpCpwNv4Ap0ggM8Mgc2Ggka5RJRXAf0bN7KNRIlMsndpv3YftPv8Dt4k4Idn4/
         LLbjve6Mt1W5UI6HLmfQs3plhwV60akuqy0CUKAurYVOj6xSo2MaKMugznb+9OFu+Vnj
         G8MT9HD8dKOoIHE/dsV+Lqm3v2ByKizBpb3K4EcmWrNrubwvtQI79WGwz1mMg4WICl0m
         0MloNnkulcbEcIUJ3PHG7GrQJ71flAi7GkqngfWuRhqRCiXbdF/dn81EhviLBTOJF2Qh
         KaeQ==
X-Gm-Message-State: ACgBeo1312xfNyKEbNgiosYDOruIOKUQvqV7MGl+X6YRKEnfDXP3vazd
        xa7wE7zJwe102sjqfp4pa5KLgCpKAQEPV/BGVXQ=
X-Google-Smtp-Source: AA6agR6f0xgcbz/jJiwHDKBEx340iRt7Ax/7tcMvNnzU6SINdVNPCvSm7LlNyy11FxYItH8Y+id8uuWVtbRpODop/BY=
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr2693929wrr.617.1659656240885; Thu, 04
 Aug 2022 16:37:20 -0700 (PDT)
MIME-Version: 1.0
Sender: rasmaneniampa123@gmail.com
Received: by 2002:a5d:6d89:0:0:0:0:0 with HTTP; Thu, 4 Aug 2022 16:37:20 -0700 (PDT)
From:   Lisa Williams <lw23675851@gmail.com>
Date:   Fri, 5 Aug 2022 00:37:20 +0100
X-Google-Sender-Auth: mskJh2IMlAJTknsluuWjbZGqJ0Y
Message-ID: <CAKOWe4C3jnyGfgvXxuZShiyykXU0dpGtbmM1qCzjtEKKCyu8ZQ@mail.gmail.com>
Subject: My name is Dr Lisa Williams
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Dear,

My name is Dr Lisa Williams from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lisa
