Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6166B2BF1
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Mar 2023 18:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCIRXv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Mar 2023 12:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCIRX3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Mar 2023 12:23:29 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7401E1164F
        for <linux-rdma@vger.kernel.org>; Thu,  9 Mar 2023 09:23:18 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u3-20020a17090a450300b00239db6d7d47so2622407pjg.4
        for <linux-rdma@vger.kernel.org>; Thu, 09 Mar 2023 09:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678382598;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28ktjE1NMsXfKN9t4WPAwEL52FnPF3RT3R2lcaspUbo=;
        b=Qo3cB964p1W2pTSU00f/OlMv0zN+Ok1XYUictYaTZ4y2nvAfEFM3XmRFLEPV2QufUA
         m0qJnZU9dGSRrYDpsEke3LYaxkQUoes8c7P9yYNewXP86Ehbi2eDT53XxPtrKsj4RrNB
         oNsbMwIWR1H2DLhNugFI7aoHEPf/IVQwC1ulQCAt6tQEVR/Rk54TQJfJPb2H8TQMCYhf
         fsgn51ouKd++Lp02u3Ne9MWllSKI0Hya67tvJDxg+ZbP7aLUc0w8JWqfergezpuDKXyj
         s2xSt8uIRV2Yo6YB1yfUGCF4F9k1ykV8rCJ6HtDHxmjCRKXOp0n9D5YZPSdYH5sByGdZ
         KPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678382598;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=28ktjE1NMsXfKN9t4WPAwEL52FnPF3RT3R2lcaspUbo=;
        b=hbGmcHhS2qQeaDn72O4EGWoS0Na5xdq+MMPGHY+91hxqWdwXa+x7FB6b2kIzDk2sBB
         cvTlJBjzYDKgP9ClZcoTu2PComyrZAOMm6/SCmkkiH6TrdxTvx+1tnckDq+IZo4x/kpF
         bQLetvxxOhtNAQ9ThBf1Zrhc86xnTCLpHquws3hX/bgGhiQNrmBo7iXBim8FtdSyArnT
         wd+x/TsihDztZWvyKYL9AwBKbSOHarFzVsE4SESO/niuHMftph2gP8giJmDapJBApKh1
         h8JlkiwA3bBqiwtzFKMrAXbEIItJ2wvcNPSPqsCmxTriYCreMY4XPfLvcRWa4JmwEd73
         Q8ig==
X-Gm-Message-State: AO0yUKV9SIopFBwEbHrnBlUQYGXKz1QBf4TeWfI+KxGDJYdYw1dzASpc
        k3jWWQeW4NPFrpi5TNCShjKxaTNV3IX21u8czpw=
X-Google-Smtp-Source: AK7set+uI2SfZmzCaW2wOFl+DYv5bkN3aAbZU4JJUAQwLS0FuMurOWrQTaWOzH7KISXSCKPwx2aPet3yGWJdJnpvZss=
X-Received: by 2002:a17:902:7e09:b0:199:6fd:ecf6 with SMTP id
 b9-20020a1709027e0900b0019906fdecf6mr8486553plm.9.1678382597901; Thu, 09 Mar
 2023 09:23:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7022:388c:b0:5e:6c60:d87f with HTTP; Thu, 9 Mar 2023
 09:23:17 -0800 (PST)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <ekon9169@gmail.com>
Date:   Thu, 9 Mar 2023 09:23:17 -0800
Message-ID: <CAH8kvD2fgdsvQiqbsg=fRktGiktvGRzz1wLtBe0OEbzV2eM1Mg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-- 
 Hello  did you receive my message?
