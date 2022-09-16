Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB895BA3B4
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Sep 2022 03:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIPBK0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Sep 2022 21:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiIPBKX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Sep 2022 21:10:23 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBF04D4DB
        for <linux-rdma@vger.kernel.org>; Thu, 15 Sep 2022 18:10:22 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id u6-20020a056830118600b006595e8f9f3fso1633162otq.1
        for <linux-rdma@vger.kernel.org>; Thu, 15 Sep 2022 18:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=6nehn4SZ+N5DitBflpC+8AB9tkDm5FI3qla1CH9afZQ=;
        b=np4RaCUtWX8kie5xR3+NYRsf86Lvh7VeIAMxOuIq718CXvBEpzkcQxvmj9NFJbbq6S
         rB/KC14woUsMii5QWF8gKo11UarH7mCNVB+g4RJwC535+AKQow90KfkgMhuaMWXgbP11
         DgDbOqunTyDTmVVwvrVuZEPV6eVd3I+2j657yHv3/HRNvKL9Pn8d4NjU5G0YxDKpCZ7i
         dOoR26svVf91E2XQHe55THbDma6dsOKMZ+B3IzFmpZrO077svkYkBTCsQq9RlI2IaExA
         RxixVRRIMS+s/o1vUzPVc3r+BqjLTesNL+87vTP6SaKdWJe3/zbEiv8G6UT05U3iFOht
         +9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6nehn4SZ+N5DitBflpC+8AB9tkDm5FI3qla1CH9afZQ=;
        b=KX4qkpM3g13gCRzctTLOvQfzjYyI/kbcflz1JozRhRNwJo4f0aAf7cKnBUpyRv+OPz
         DJi/f+/PjEi8P07Y+5tAIam+FPSoh8xItPY2bTTiMSkF2PoIryMFfTIcfjRO1l8uJURG
         18yB8cl/WtTU+86p/o7q0MpP5XYpZ8rAo1RIV4HD6yjM9boIx9528gOZlQn37oN8Ttrg
         IOb942S80XhLarCBAxwdm/HxAhgIR4bzr5+QCXt/FKK6QZKoIiZIwK1LOSEW3WyAz63B
         Z9gy8OuJQc8gjWhDdAhigGTFBJQsFD10yhuetMIPEITCnFKvYJnXywAhnZyNU2OisXGl
         pKVA==
X-Gm-Message-State: ACrzQf04lRSIo6FNNuRsUVy8zmBPUyKPxGohQe/4g/Bam5danitcMDBH
        CXPBIMWQoX1qDPZVskcOCBZoMrmYrlHkmUS5bQ==
X-Google-Smtp-Source: AMsMyM6Ip9eJ7x168CMGYhYckHP8WIm7hEZDQ0vUIDP7Xb5FYoinF0pKq2hsipyTSj1ypuXP/4z64t1g9QETj1D31sc=
X-Received: by 2002:a9d:75d8:0:b0:658:fff4:371a with SMTP id
 c24-20020a9d75d8000000b00658fff4371amr1186676otl.314.1663290620391; Thu, 15
 Sep 2022 18:10:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:d001:0:0:0:0:0 with HTTP; Thu, 15 Sep 2022 18:10:19
 -0700 (PDT)
Reply-To: un.loan@unpayloan.com
From:   Tracy Vornan <graceali1977@gmail.com>
Date:   Thu, 15 Sep 2022 18:10:19 -0700
Message-ID: <CAFbUGG8L+5-JUQFZqozCNRsazdebrJoCYaWtFMUsLpK3uABzGQ@mail.gmail.com>
Subject: Apply for Loan
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-- 
The United Nations in partnership with various financial bodies is
giving out loan grants to help qualified individuals and organizations
reimburse their businesses. This offer is available to everyone across
the globe and is targeted at helping economies that has been downed by
the pandemic.
