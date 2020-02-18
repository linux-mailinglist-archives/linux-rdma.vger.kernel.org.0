Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E703163648
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 23:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgBRWkP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 17:40:15 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:38595 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgBRWkP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 17:40:15 -0500
Received: by mail-pg1-f180.google.com with SMTP id d6so11654936pgn.5
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 14:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QxxgKlOI18XFx4RsiwmtX0xz3YL/rs7skcoYUa+GEwg=;
        b=zTUXwIQaULx8QdyzmW/nFca/kfT/qenV8nuYvTAQr4KRG5XS8VljPEI0woADTHsNCf
         1S9nXE42adZv/VSV4tnPbMDDLGtj9dM7p1YvLh5mzHq4THAAp7rD4RIRwKHHZEx/tEYo
         sDmmXvkKyiUZzs4rxy743z2YwVIAvy43Qs3hAH3DfTD1bMtOCb7Cy5xYZ7+19VnwLaUv
         J1QGD1I6DiwRrR2fesbTPeFFLkdKtaijBZD8UhT/P1DEcFQ5vTUAaphiA00rk95Um3TT
         gV+fd1mTz93msI4gJX6rM5RyUPv6tSQhZ+mnyWxAO2Lx2VxDTylCXyG+usGDG/RIny1b
         WNtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QxxgKlOI18XFx4RsiwmtX0xz3YL/rs7skcoYUa+GEwg=;
        b=NeTu3FXVw6/YFwPQ2jji17W8m5xmyaz+dmfitP8AhRORPjd8qASQjPzET/lHXKLVvD
         JBlmt2MmqXoPnwS/6z7lmnvpsl/vKe03GicwJfJinS8PiCdHO6AU8PdNi5mbRFHNAFRs
         wMCnM3OiOBzaF51Mm6LZyrYEREuwTRiKgEqeszEWN505826KAHdlng1rSkM7u2EXqxI0
         gUkc1C2CEnnrQL9BiHrR6okBLniUA7TIOqCaoa/hlT0FPZ1MYTN73IHQAsoHLIoei1ZP
         gNsLmMwRSYSfBiAhUoJqhRb+s4i6iKG2HCD01CBJeqOZ95QPServa7Aw4RiY8MFMXKae
         owZA==
X-Gm-Message-State: APjAAAVD5p5QY413rGyFMPwkFq5+FTTTRwXR77Dz2WCabZOqHGZRqd40
        36J4sNpKP2oETszoR1xGbXGg4A==
X-Google-Smtp-Source: APXvYqwt9yUGg/9Jf9qNxZmZbGx0r6W9R3aQ1gEk1Wt/2+BXhffp2dqxnrNaTIjJ6DG+nwwMVjK/Vg==
X-Received: by 2002:aa7:84c4:: with SMTP id x4mr23527207pfn.144.1582065613248;
        Tue, 18 Feb 2020 14:40:13 -0800 (PST)
Received: from [192.168.4.6] ([107.13.143.123])
        by smtp.gmail.com with ESMTPSA id g19sm22576pfh.134.2020.02.18.14.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 14:40:12 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: May we create roce_ud_header_unpack()?
From:   Andrew Boyer <aboyer@pensando.io>
In-Reply-To: <20200218205817.GI31668@ziepe.ca>
Date:   Tue, 18 Feb 2020 17:40:09 -0500
Cc:     linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <86758DBC-E3E6-4E96-B2E0-10ACE4F5228C@pensando.io>
References: <ABA12A9D-D4F4-405C-BEAA-BDBF33D50488@pensando.io>
 <20200218205817.GI31668@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



> On Feb 18, 2020, at 3:58 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Tue, Feb 18, 2020 at 03:53:45PM -0500, Andrew Boyer wrote:
>> There is an ib_ud_header_unpack() in core/ud_header.c, but it has no =
consumers.
>>=20
>> Would I be allowed to add a roce version alongside it?
>=20
> Why? Personally I loath these accessors
>=20
> I have been thinking of dropping all of them in favour of the stuff in
> include/rdma/iba.h, which has really been a good improvement to the cm
>=20
>> May I do that now or must it wait until a consumer is ready to be =
checked in?
>=20
> New stuff always needs in-tree users.
>=20
> You can send a patch to delete ib_ud_header_unpack() though
>=20
> Jason

OK.

It was being used for query_ah and query_qp, but I can design that out, =
no problem.

Are we still permitted to use ib_ud_header_pack() or should we avoid =
that too?

-Andrew

