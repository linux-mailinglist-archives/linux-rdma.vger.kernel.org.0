Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A374962E85A
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Nov 2022 23:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbiKQWYe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Nov 2022 17:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbiKQWYM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Nov 2022 17:24:12 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4257AF6A
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 14:22:43 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id l8so4527628ljh.13
        for <linux-rdma@vger.kernel.org>; Thu, 17 Nov 2022 14:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6z/H/hUdzby6qzD77X8A67itjj5DLg7zeEm5yiK8ewk=;
        b=eE4LiOIHFvyJHY7TCuARlwSw6Fxj3RoALWhC9BTrYw2hyYbtcHjUsNVUOiniWdZCFQ
         Rsv4SOdZhTUmrW+oHsj2Kb5Nve8M3yTYlEASqDEv9vFrV0udjI04LpHlfEIzneczAqIo
         cLlniHaU3+rIJq6TAq8ESm4HV4ST0kGo137LrAiwxlLpObLlxqnA7EWSRlYRh1KoHFz3
         tR1zX85c3nfv+7p7Q6kmWI7iaX/M+acHF6e/aHABMB7h4IfmqiaqH2Hgi2JpPt9mtlx/
         rzG/2SVNL9yVatDL/fKPhGcrrMCVSK53fbcVJYJvOcPV6+SFNHCncWoqAcSBIkCiHBoB
         GwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6z/H/hUdzby6qzD77X8A67itjj5DLg7zeEm5yiK8ewk=;
        b=YTyCzWNMrNMBIlavntAs4oU/TyD0kO6012dKTqHG2JeuV+YAKmILem5EHkopHU8B3o
         qwwue+kzNl/dh+6sPfb4siQsVlxXQLoX9hrUb5+emsSzFXNqQb0SA6HXS/iXK5Z27x/H
         Mc6uqkm4g5RVQyJOzbairhpu3CbsXr93AHA7j1MeMj2SHI4yZQ3OgbXUmyPrnD7WuHVF
         PlxmLl0c9lHP6i4hGcw7NvoNSwD2YF8DAAPgEyDNLZh/NAbqWT4advtNWnshbK40L2M1
         xaQWaDJ6JffhgSzyNwh8b9AbbSLbsBmnSfmydcLo+w7Q2oaXbr/9CMnskq0+PCfZy4I6
         E64A==
X-Gm-Message-State: ANoB5pliAR5n2eKqpqADYbmLi4d3jpj7eowxrdEpnTzos9p1tnRAgZzh
        Mqsc2zNePI7FVvB9j81TexaEmyO7suxl4VETgNUGEZUqM4s=
X-Google-Smtp-Source: AA0mqf5+3d83OHwdcEp1GMffOoUPH2NG2Ir5kPpXpkI1tPtt7kGd2jzVeDtSIET1guqGSM3l24+zC0BpVlpsAr5MVHY=
X-Received: by 2002:aa7:d307:0:b0:461:91e1:368 with SMTP id
 p7-20020aa7d307000000b0046191e10368mr3838155edq.327.1668723751655; Thu, 17
 Nov 2022 14:22:31 -0800 (PST)
MIME-Version: 1.0
Sender: gnimgimegang@gmail.com
Received: by 2002:a05:7208:5486:b0:5d:220d:12fe with HTTP; Thu, 17 Nov 2022
 14:22:30 -0800 (PST)
From:   =?UTF-8?B?0JvQuNC30LAg0KHQuNC00L7RgNC10L3QutC+?= 
        <a45476301@gmail.com>
Date:   Thu, 17 Nov 2022 22:22:30 +0000
X-Google-Sender-Auth: _nMiJUMiDaAgQ1ujl_JkAGMSFiA
Message-ID: <CALvt0+=rj8-1zj0pbCYDi_Z+7=H3DeA_soSfHtThNRTz2UnFYQ@mail.gmail.com>
Subject: It's for you.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Greetings!!
Did you receive my previous email?
Regards,
Yelyzaveta Sydorenko,
