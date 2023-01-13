Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA56694A1
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jan 2023 11:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbjAMKtW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Jan 2023 05:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241305AbjAMKsw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Jan 2023 05:48:52 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7FA6084E
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 02:48:41 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id o75so21919171yba.2
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 02:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cv6s8e/NACyDmRat1cOMwCBUHvrOgb2DOGVBYCvGIjo=;
        b=dv7zJUajXwLlSIgbPIyKD9DL2i98r6RbL+eopEMxKYNynlp+1uHPpBfbZWd21iRLLd
         AGuvnKHeZOeDZ9VAZIoNzCL8fmMEjD2xd1O5bwaPffvqYXNGrn9/HfVdNOm95guJra4Z
         0TtXA8s/Pfm3ACfIkV7evyIaGRZAFC1BrV+s/70mh8lwmOH2uI2bmk/LbsiN369qaBqP
         R9xIOE5Rve4Yp1Rk65P3NVsbbeJQnJXWJn+bwWH8l/m8HXE80/13QKBieDPUXtf+4bNb
         K8bju6CgNCNHu87WwijeEApIkdvjY1Jdid1Cbo91xVhqAtBf8acuA/yzDf8MpIk3JqhY
         FCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cv6s8e/NACyDmRat1cOMwCBUHvrOgb2DOGVBYCvGIjo=;
        b=DjdNJJYjIgNHe7e0e/RjjcnhUgunGpielP7O5KLpL4QlcfA2FeEAaENbrpSDLoNlsm
         VlO51nBZe+kq/VLzH1e2dSgCYyhNQpfj4jsv1EJPBQXJ+mdQpByH1I88GdhN1VsJn2Od
         SrNvUGufvhA0JtVUZ95z36iU5lSrX2Z/jcL8SY5RUqHgCg65KPbTtZk640jHYJZj5liI
         14B5MHsyGiCO89+6PZFBi2styRmyGcopOMxoKqrDb+oaoLcdRrPktHMw0HttY8XosUAQ
         cLW5PsQUzSYpGUZnaqxzOPcAfk4VnJ5rM9VwfxL2OxKEEjEUmxn9IhRX9E3C8xU6zLDU
         JXew==
X-Gm-Message-State: AFqh2kovomvz+kOqX9XnpdPMgUe5HhyFySP99fG2ZGwsaBKSeZgrEH5x
        x9yYCawMD8y7Y7CmjeXtaFD1ZYL58fFgc9Hj6Wg=
X-Google-Smtp-Source: AMrXdXtjp7SixE7QlkXQMLcH7EfalbJbJW0ibwDwOLZ9W0XAZ9/k+uJFssxiQREMHHKzdDcf9Y6mH+9h7juL6ex5i1I=
X-Received: by 2002:a25:3458:0:b0:7d0:ef60:d1a1 with SMTP id
 b85-20020a253458000000b007d0ef60d1a1mr61255yba.586.1673606920730; Fri, 13 Jan
 2023 02:48:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6919:b01:b0:ff:f811:51a4 with HTTP; Fri, 13 Jan 2023
 02:48:39 -0800 (PST)
Reply-To: faisalali.faris@aseelfinance-uae.net
From:   Faisal Ali faris <howardfahie1@gmail.com>
Date:   Fri, 13 Jan 2023 11:48:39 +0100
Message-ID: <CANhUALf327=vFgj3+tSVD0c793RGwS8zTO9COLW=ScdrVGqOWg@mail.gmail.com>
Subject: Dear Sir/Madam
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_50,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Dear Sir/Madam

We are into project financing/investment funding programs. If you need
a loan to fund or support your projects let us know.

Best regards,
Faisal Ali faris
Aseel Islamic Finance Group
