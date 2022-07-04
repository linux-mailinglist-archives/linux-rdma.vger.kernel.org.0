Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEE4565141
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Jul 2022 11:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiGDJrT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Jul 2022 05:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiGDJrS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Jul 2022 05:47:18 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC511E7
        for <linux-rdma@vger.kernel.org>; Mon,  4 Jul 2022 02:47:17 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-31c8bb90d09so22845247b3.8
        for <linux-rdma@vger.kernel.org>; Mon, 04 Jul 2022 02:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=E61+1ZXk0XLFmLKS8+LHaQBAQCUVSplsnRDmkf+keqM=;
        b=B8mQmiPXLjbVr0anIumhF3sj6NJefl/XX80UrMCoOzLK589rvaSRX06XDwxeQswkTj
         UjlNwboxVlV8DXQNC8KXxU6+TuvAMLfehepGIqPbG3pVr14z5oqJGZMTWjT4i2FCQNUH
         WKreeyLdFeMjH9ZXUwLOjMeLtbAxYQ/FrlBkQBBkcINbeWYz6F4M/fCCUWnGo4cfHPvw
         oPm8b1zixm3P1NZAiPXs8fa0HU4S9ChLON24rvgxSdDSAjvuknkt1ZKh8QlwQMrHC4Wc
         8cJIl+i9nlk8af4kAeE2/geMiP4lBK+qfJqZyeZRhouqOuSTFe0+K9HGE7f6kEmhJl6c
         P0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=E61+1ZXk0XLFmLKS8+LHaQBAQCUVSplsnRDmkf+keqM=;
        b=GID4aQ++9/p7lylXYkcL2c6p1515JLjn0cBNGyazFofBhIrYLAgfoPd6PwfcHq9cxn
         WP93PcKEM5e9GTqfb7Rcm0xKYAS5SpVEqB7UQ1TPNijP0CekQmtF0CMRdL2pP4X8RGt+
         kM11camiGi8yFbyZwDtFbrdCqrlxbngTbpN5YfLIl6Ayv30f2uuPaV/KBG9tnnGFB1Ip
         duSFBsNZgs0B/oJdpCuN8HrQIrDXxvAC0Tv2JIPzz7Rn1quxTg5KU+iTy5iJBMVExYBS
         8JJ1U387XvoxIyZwiFYaVi0etwfC7AnmFNPeQrUP1h0e1wLCsM1sJFSKK9ujC/A8+mhb
         LetA==
X-Gm-Message-State: AJIora8PgagACmnLBIlLh4QTazdXQ4GWNoiUby9Tyua8RPM6ZX9obUYP
        vXVn/L/Dn2w1Xl5SyhqlpYvPi4uce3z4WGb7HIo=
X-Google-Smtp-Source: AGRyM1tREqTz6WF+h401HKy7fRbBwQHGenwNsoDURJo31pLYXTYSvME7WtOsfgtClXeIYD6GDpBagjuKIL3R7A0DBkE=
X-Received: by 2002:a81:9cb:0:b0:317:b68d:59cf with SMTP id
 194-20020a8109cb000000b00317b68d59cfmr32479055ywj.296.1656928036668; Mon, 04
 Jul 2022 02:47:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:5286:b0:2e2:3648:8c0d with HTTP; Mon, 4 Jul 2022
 02:47:16 -0700 (PDT)
Reply-To: hj505432@gmail.com
From:   "Barrister. Ben Waidhofer" <musamuhammadyusuf2@gmail.com>
Date:   Mon, 4 Jul 2022 02:47:16 -0700
Message-ID: <CAEfE=vF0V56Zn-jJu9fk2+zYy3q8eQe0r3tdDha0jB_kU246Lw@mail.gmail.com>
Subject: Investment offer
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

                                                 Barrister. Ben Waidhofer.
                                                    Chambers & Partners.
                                                       42 Parker Street
                                                            London
                                                         WC2B 5PQ.


......I am the above named person from the stated law firm in London. I act
for Mr. Andrew Walker, a former loyalist and a personal Friend to the
President of Russia Vladimir Putin presently in London; he flew into
the UK months ago before the invasion of Ukraine by Russian government.
The sum of $3.5b was deposited in a Private bank in Switzerland for
the procurement of MIC war equipment from North Korea to fight the
war, but he has decided to back out of the initial plan to divert part
of the fund for investment in a viable venture.

There is a need for a matured and trusted individual or corporate
organization to receive part of the fund. All the needed documentation
will be perfected here in London.

You are at liberty to respond for more detail.

Thanks.
Regards,
Barrister. Ben Waidhofer
