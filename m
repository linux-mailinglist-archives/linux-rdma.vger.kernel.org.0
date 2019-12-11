Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E5011B873
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2019 17:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfLKQUd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Dec 2019 11:20:33 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:45733 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729278AbfLKQUd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 11 Dec 2019 11:20:33 -0500
Received: by mail-oi1-f178.google.com with SMTP id v10so1022095oiv.12
        for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2019 08:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3D+njxdemE8ZErJY2f5ENgLrX6vCdSlLn9pGZUd+ob0=;
        b=kLBAaT79A9+UBujTtsJN6rkoeCkHiSVsjiaaT1wMMW5oHrh2MEonL6HHvXs/Turjqh
         gdt5r4okuORM1WWu3ujscUUUd3U7ZXbGaRhy6nBrg4DBGyPH5Pf8fXeVw3/5J4hJhDyo
         GzkDYEMkEnErSMske5V1X+iBCfyilJXE3VsCTUxoDGQtjLgAjcXlwVJfoV9OHU46unHo
         wiU0o3wDEqVA2xXx+bt6KTken2ss8lIE+/zHo6/DF2EBOWVlZxuCZbniH7GoQjoLvEqM
         wkyVuN6BMUBZ8/zFv7khRAOxw91Q8J6b02HgHLKPsOjrwsdTixs1rY1fHaLQovacgccp
         quzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3D+njxdemE8ZErJY2f5ENgLrX6vCdSlLn9pGZUd+ob0=;
        b=gMSyExJi9uHmoOjH0WhqKLxhtZ8DqjItsxOR9Wn6eoTXQj2Vy9qaB/zsCtX6eywHwL
         0Zq8uhxTz1UaWtJHeGYDINtET8M+HtsM4fzs1AlCiz1R7SkGmEjTgbZdFuKtdgTERmRV
         cHI9NN6/a24xngsHGPf6zhZvo4xRDs2VeMafjcnzRWCAypDsXpkGHQ6yEUyKVy6frvyJ
         PcUpiWIuaJ/Kr+TMyVndNgxG+HF39at3OfzPoLQQpkA75oyE7PxfhThxQNYv+c5rSOqn
         K7L14KPpxi+/5rXSbZ6nZq49iUk+WFfQQtL5val939sIgs6m77i1v/UFzej79w9iTN21
         ig/g==
X-Gm-Message-State: APjAAAUO4stIxa9PnatEk3SkeU/59vkOdXIlIptksCIGIZft9ioW+DSw
        VLSTx6luA+xHCXI0dkMT3m0utg==
X-Google-Smtp-Source: APXvYqz8MnCeDEZ7zUjClHNarXeA87tM2obCnSz7hWS8eMwt2gIOf7BMDiGZygoIRAwrZmPEuQSeBg==
X-Received: by 2002:aca:bd42:: with SMTP id n63mr3479564oif.70.1576081232151;
        Wed, 11 Dec 2019 08:20:32 -0800 (PST)
Received: from ziepe.ca ([217.140.111.136])
        by smtp.gmail.com with ESMTPSA id x202sm455060oix.14.2019.12.11.08.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Dec 2019 08:20:31 -0800 (PST)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1if4j0-0001s4-RT; Wed, 11 Dec 2019 12:20:30 -0400
Date:   Wed, 11 Dec 2019 12:20:30 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/6] RDMA/bnxt_re driver update
Message-ID: <20191211162030.GA6622@ziepe.ca>
References: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
 <CA+sbYW13n4BBGRwohMDg6iAOd-nFQXn6SUp8cDLY0qAgpqbZpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW13n4BBGRwohMDg6iAOd-nFQXn6SUp8cDLY0qAgpqbZpg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 11, 2019 at 06:27:25PM +0530, Selvin Xavier wrote:
> Hi Doug/Jason,
> 
> Can you please confirm whether you plan to pull this series in 5.5? I
> marked it as for-next. I was not sure whether it was late for the
> current merge window.

It was way too late

> If you don't plan to pull this series, can you please pull patch 1
> and 2 for RC? Both are bug fixes.  Thanks, Selvin

I'll look at it next week

Jason
