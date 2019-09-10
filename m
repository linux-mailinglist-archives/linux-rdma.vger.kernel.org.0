Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B0EAE4B2
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2019 09:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfIJHb1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Sep 2019 03:31:27 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42784 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfIJHb1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Sep 2019 03:31:27 -0400
Received: by mail-qk1-f193.google.com with SMTP id f13so15970214qkm.9;
        Tue, 10 Sep 2019 00:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J4aIbTcgYnsL2jAn60izorNqL2E+CEoVtmdgC/gCJ2A=;
        b=rA+YV42bahdlJ80KZYTG6Br/IowEbQmS5Ti/4npAstLMK+yviYQ3Bcgsz2fq/TGbHF
         duOfieiqXaTGK/YC7wEM4gL5Ut1F+JJLXs52bePD3n4DwilGs/viE8ttiv/u6yfyMhbw
         EocqobjA5Ha8Nz2wmUdnJgTK63rWAVTHOn32mldsL+EvLjzmbvuiPj09PK3usQHrQRmT
         3DtD78DOZUrmTj5lW1I1iWt3yhF0SGgNcNJV8NyCSz4Dg2/Jt3ahMSivNgLJj4Y7jTr+
         +MFWsPyxBUteSGgfjj0iw7OavAjdw0wZo9P4LiSNITPNtYEN3FeXJg8Ac9awCOkvYIV3
         zvpg==
X-Gm-Message-State: APjAAAVWDyJebX/TmJ1XHcnUIxtqbEOQXJ+KeokVomo0nL6OF9Jcdwxy
        6487PwdIIbFFrZaumE168c6hrZQka8yHHtLSmRlR9Yp1
X-Google-Smtp-Source: APXvYqzxfu9hm0NXuOKA2ZPbbiK1FbMXuncwD0ThgVH5KBnNGFfYb5fTYOiTxWRMVJbtLh9Ew4O+xiYHL4ZLpkip+vI=
X-Received: by 2002:ae9:ef8c:: with SMTP id d134mr27834191qkg.286.1568100685778;
 Tue, 10 Sep 2019 00:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190909204201.931830-1-arnd@arndb.de> <20190910071030.GG2063@dhcp22.suse.cz>
In-Reply-To: <20190910071030.GG2063@dhcp22.suse.cz>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 10 Sep 2019 09:31:09 +0200
Message-ID: <CAK8P3a2_nuy-nxYapRbkZfAa+xABGUSPekEOwTunu4G-=V2cCA@mail.gmail.com>
Subject: Re: [PATCH] mm: add dummy can_do_mlock() helper
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 10, 2019 at 9:10 AM Michal Hocko <mhocko@kernel.org> wrote:

> but IB on nonMMU? Whut? Is there any HW that actually supports this?
> Just wondering...

Probably not, but I can't think of a good reason to completely disable
it in Kconfig.
Almost everything can be built without MMU at the moment, but the subset
of things that are actually useful is hard to know.

         Arnd
