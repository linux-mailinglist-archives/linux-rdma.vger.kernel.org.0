Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 423016790D
	for <lists+linux-rdma@lfdr.de>; Sat, 13 Jul 2019 09:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfGMHwH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 13 Jul 2019 03:52:07 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45033 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfGMHwH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 13 Jul 2019 03:52:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id b7so11740925otl.11
        for <linux-rdma@vger.kernel.org>; Sat, 13 Jul 2019 00:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YsoYwe6hxpLRheeL+2UgvVYli/JGpU8mUW7jSKwkKqs=;
        b=LOp8cpKNoLNUsNIKfv282/gUZq2qG5yniLmHV1SN79nx/kjYb2cYxCIbNpncNJiLbm
         tOOtTWUZBfGRftjbdJA+B2H81tUG+uEM9CB+VaFBIXHWZ4GIGQogrXNxE61cUQPMku/7
         LscAaqWoVOZM3nnQkpRjiA/u7HpJf9NEe/BTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YsoYwe6hxpLRheeL+2UgvVYli/JGpU8mUW7jSKwkKqs=;
        b=G6yMMztef2OPRWVwHzIi+gtvDCEDRCU7uLXUWUApO2qZRxYrG5Kd1n24nd+RwTj8oY
         ONjONmgeBhVu+8Uxv4IXaV4j/L19LGoZLvGqemg5LhkSLXyL6m0SmW9ekAsSSXD1g42b
         zHJEcnTxP5q1PMwjGydlvfIxoUOV6nPvyNcopd8iQP4NFSZehJ81ik7ojRmfT7PyIkzZ
         uFdIJTP5Ts1oBkTsaKzQvVuvgvg1t535KRbxYjEAbJyPUweDdPoC6UGcyc2uB/mjI9KB
         X5pDH0uVvueKRwG+hBXVL8k/MrlIXo8iM4/js+jRVrbThQFCvMuq1+60hqJkzyCy39Pn
         ocSg==
X-Gm-Message-State: APjAAAUc3M1Wx3XoA3hanqcBFZL/Ji7/D6jLk/dtUIytRDIFmdqrg5nT
        RLSweRNlh0TuxWHCzOzwcwyFW4VnEfU0kxAierNJGQ==
X-Google-Smtp-Source: APXvYqyDsXA615XyYaF8kUBB6KAk42S1QBYDp19Be9oKoBPK8aD+0k13VWXJWIG1Jw8xk48tJD4eQPpo7XSKDJc8UXA=
X-Received: by 2002:a9d:6e93:: with SMTP id a19mr12015771otr.216.1563004325846;
 Sat, 13 Jul 2019 00:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <66d43fd8-18e8-8b9d-90e3-ee2804d56889@redhat.com>
 <AM0PR05MB4866DEDB9DE4379F6A6EF15BD1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <CA+sbYW17PGAW57pyRmQB9KsDA9Q+7FFgSseSTTWE_h6vffa7UQ@mail.gmail.com>
 <AM0PR05MB4866CFEDCDF3CDA1D7D18AA5D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866CCD487C9D99BD9526BA8D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB4866665D5CACB34AE885BCA2D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <ef6a01a1-9163-ef4e-29ac-4f4130c682f1@redhat.com> <AM0PR05MB48666463325E1D0E25D63F57D1F20@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <20190712154044.GJ27512@ziepe.ca> <CA+sbYW0F6Vgpa5SQX+9ge4EwWrMkJ4kQ-psEq11S00=-L_mVhg@mail.gmail.com>
 <20190712174220.GL27512@ziepe.ca>
In-Reply-To: <20190712174220.GL27512@ziepe.ca>
From:   Selvin Xavier <selvin.xavier@broadcom.com>
Date:   Sat, 13 Jul 2019 13:21:54 +0530
Message-ID: <CA+sbYW3Pp=qwky+myAEkiP-9TOui+9=DSyQxivNuSEsD8K4CFA@mail.gmail.com>
Subject: Re: regression: nvme rdma with bnxt_re0 broken
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Parav Pandit <parav@mellanox.com>, Yi Zhang <yi.zhang@redhat.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 11:12 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Jul 12, 2019 at 09:59:38PM +0530, Selvin Xavier wrote:
>
> > > bnxt guys: please just delete this duplicate detection code from the
> > > driver. Every GID provided from the core must be programmed into the
> > > given gid table index.
> >
> > Jason,
> >  This check is required in bnxt_re because the HW need only one entry
> > in its table for RoCE V1 and RoCE v2 Gids.
>
> The HW doesn't have a 'GID table' if it has this restriction. It
> sounds like it has some 'IP table' or maybe 'IP and VLAN' table?
>
> So the driver must provide a full emulated 'GID Table' with all the
> normal semantics.
>
> Which looks sort of like what the add side is doing, other than the
> mis-naming it seems reasonable..
>
> But then I see this in re_create_ah:
>
>         /*
>          * If RoCE V2 is enabled, stack will have two entries for
>          * each GID entry. Avoiding this duplicte entry in HW. Dividing
>          * the GID index by 2 for RoCE V2
>          */
>         ah->qplib_ah.sgid_index = grh->sgid_index / 2;
>
> Which seems completely wrong - that is making assumptions about the
> layout of the gid table that is just not allowed.
>
> Surely it needs to access the per-gid driver context that add_gid set
> and use the index into the sgid_table from there?
>
Agree.. We need a mapping between HW table index and GID table index.
We can either maintain a mapping in the driver or have an ib stack function to
get the per gid driver context from gid table index. The later makes sense
only if other drivers also needs such interface.  I am not sure any
other driver needs
it.
