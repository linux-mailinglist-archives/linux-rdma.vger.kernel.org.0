Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45A87B17D3
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Sep 2023 11:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjI1Jtx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Sep 2023 05:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjI1Jtw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Sep 2023 05:49:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F56194;
        Thu, 28 Sep 2023 02:49:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40651a72807so4396205e9.1;
        Thu, 28 Sep 2023 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695894589; x=1696499389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vzfhqp3aHBxi81Dlx2RJN2eQ5TUPeumRybhgJy7nz4s=;
        b=jTXnlIIimoLiBTes2sLrmrHf0KhC/1OFt8LSJ/SPAvL5nFWdFJghfFrqYBNs0fT4U5
         fa21lAvpMFJ03h0mhtVulqlhHZDkoE4NRS+O+mqpNRz4Ok7mj4XGz6/a9Noirep/dErn
         hXpeUwsvOzHTU3Hm+oWHh7zueOVo9xoMxnEPsv6XxmmnZm9fg1dHeJmGOEGD6+DZ9sqn
         4ALVwf+/OwLcI5WK89A3xdlvQXlkb83tLs8o+fm66GfSy+wydFEV2agJUsoFjHqcf75P
         HRmn2fz4n+ZMMbf71wj7RcI6xEf2z9pBnCtbp+ZOVD5GUkvS62GkssGco0eYLzW9Bi9O
         Y5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695894589; x=1696499389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzfhqp3aHBxi81Dlx2RJN2eQ5TUPeumRybhgJy7nz4s=;
        b=Rh6Shdw5VkZ85PrKjlpkMs4M0+2HZcAI81w3HqqaIwZ9pdmnWVeCdskbFV/xQzviRS
         4CdnwZA5EaenJ8o03VLSlg9LRCyn5p8cCVj901z6sZjTiYzwvnNcQtE/U64ZG9UbVEpW
         smeLMfWKgQoZ6sNqoyjAvmYrfikl0+4KOIIgwwYQZFUQAAxwibwUIWjvOGQWq5ssKQsz
         GjPWpDIH3HnbSuz05U8GEvxoFvLChugzxRfZxsHEW9WD4wUaDAosbqWlr8AhnSWuatEn
         AXLv+WDJd8+tHUQPLm58h8DgL1L7BbbQ5QTnVtoCB4DLySuw+qn2/HOcAom3d1eW6azk
         28ew==
X-Gm-Message-State: AOJu0YwixslqEV+djnKeC5LcN2KdMN3bfFYCGjaPQHgb9x6FZix6EkDp
        rIOoyoUJD0A5et3LaowC28PyZX7LMZlfc9w5S5/BjgrJ
X-Google-Smtp-Source: AGHT+IFM4PTnzdKDMAZdpTUeZ4vH6tF04RpVIhp75XOkxAasu4tUiv50B6Fz/JnB2KYJW9ZqrDXJZEFQL86o44FX7II=
X-Received: by 2002:a5d:49cd:0:b0:320:5ad:2b9c with SMTP id
 t13-20020a5d49cd000000b0032005ad2b9cmr918984wrs.2.1695894589074; Thu, 28 Sep
 2023 02:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230926102331.5095-1-dg573847474@gmail.com>
In-Reply-To: <20230926102331.5095-1-dg573847474@gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 28 Sep 2023 17:49:37 +0800
Message-ID: <CAAo+4rURKSa5oQwGr2Pg7BjUbUSKL=SMBN0mHK9BZQTHvGb4ng@mail.gmail.com>
Subject: Re: [PATCH] RDMA: Fix potential deadlock on &dev->rdi.pending_lock
To:     dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca,
        leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

I just noticed the two callbacks already called with irq disabled,
then the patch is unnecessary, sorry for the interruption.

Regards,
Chengfeng
