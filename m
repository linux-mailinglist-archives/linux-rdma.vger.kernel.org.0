Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0A941C26
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 08:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730975AbfFLGXb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 02:23:31 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:44837 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbfFLGXb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jun 2019 02:23:31 -0400
Received: by mail-oi1-f173.google.com with SMTP id e189so10826679oib.11
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 23:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kURH5ziMumFX0q8s9pLDJZDdoVeLbHT0lZrOne621pA=;
        b=Eyq1cG9dTUjyO7BhaPmXGnsbNrZ8QL1rBMGryIEB+lbspVs4jdN1tj9ThtdIJggx0Q
         VWAl1FfQi5QcaBufc7Ko8Zz/TbIH7y1zw1Llmneuq+pmjNKqhTOu2kaQx2Eb4boCbzIM
         bfhIRvkzHPvGGnoYGWI/MJiTWu3Ztx8nygbQ8haDAGutl7dzIRaS/O8/HD7/GlXIp1ml
         rYjMJY6f7cUDih+AM6K7DElpRuxV7/apBSgF7nh+wIFcSuLTmvmF+KicbeRS+lJbJC2s
         yVvd4e7Rl51JXk3aUZSPhRiM9lPidFdYK+LmKmL7tlIY1IPW+Fwk2NYy9I0wajkpl6ZI
         4cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kURH5ziMumFX0q8s9pLDJZDdoVeLbHT0lZrOne621pA=;
        b=R98m7P25+7bwVwPk17Vn+RxBBnvIQJAQ7FLBVGO64SrWQfeNalD4f4ckCHdJPC26hZ
         4BOpdydZiLvDX4G85UgHbrwOap6KKbPDa9KgXNTbBBYsDcSspE07TgBWKo19IP+cWQ/E
         jjGiZFM9FLR118E8u+bnFNwAGtW6J+o3tB0NOSXYcP9j4/p7pw1XgdzFsjcOM/eOCLxL
         dz04MOZrmp8RCTjUVUxfRXgsPwrq0crOU9i27BmPvrhBf6q1SyofWImGaM2IT/Xnilv5
         tdA1bpji3YldEjCQ3TxzrUh7DtgtadoHcfoqd5K6kjvxI3cWUelZWer0KGCIF9nCkhP4
         dlSg==
X-Gm-Message-State: APjAAAWvbDoj2LnwBAPcMDedTBIOPGOGrzHp93K2D+0qVEG3nl4Ohv4H
        eCvPz3K6GnTQfB6u2MSD/HRow9VIzht1hX02CVjGO789mYE=
X-Google-Smtp-Source: APXvYqw+BN3+rtJvRdAbZgKJ97hpOM0OYbbM962RlDTDTw16Cwe+Ncee9iZOLybsQfH+kGmfZvovET5vapqevpPlFps=
X-Received: by 2002:aca:5a04:: with SMTP id o4mr8132724oib.36.1560320610076;
 Tue, 11 Jun 2019 23:23:30 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Elrod <elrodc@gmail.com>
Date:   Wed, 12 Jun 2019 01:23:12 -0500
Message-ID: <CA+pTmbCAd47NbJ0=QxwUHZRtyqdx61sFv6P8nyRPtxi-mk_A4Q@mail.gmail.com>
Subject: Failed to enable unit: Unit file rdma.service does not exist
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

- Linux distribution and version
Clear Linux (29870)

- Linux Kernel and version
5.1.8

- InfiniBand hardware and firmware version
Hardware version: MCX354A-FCBT (FDR)
Firmware version: 2.42.5000

Problem:
$ systemctl enable rdma
Failed to enable unit: Unit file rdma.service does not exist.

More background:
I have 3 computers and 3 cards. Each card has 2 ports, so I'd like to
directly link each computer and use infiniband with (Open)MPI.

Clear Linux's package manager provides rdma and rdma-core, but doesn't
provide rdma.service. I do not see a /usr/libexec/rdma-init-kernel,
either.
(Same story with other packages, like opensm).
I made a comment on the Clear Linux community forum, and was told:

"""Upstream does not provide these files, and this is explained by the
age of the project and the amount of development activity.

This is one of those problems that should have been solved upstream.
If we add unit files, they=E2=80=99re most likely not going to be correct
since it=E2=80=99s unlikely that anyone on our team uses RDMA/opensm.

YTEH - You=E2=80=99re The Expert Here. It would really help if you could
investigate what the proper content of the unit files are, submit them
upstream and Cc the clearlinux github issue tracker. Then we can make
progress instead of blindly adding some untested and copied unit file
from another distro."""

https://community.clearlinux.org/t/unit-file-opensm-service-does-not-exist-=
provide-opensm-service-files/762/4

I see for example that you provide support for Debian, Red Hat, and Suse.

What is your policy towards other distributions (that aren't built on
top of those three) / what are your recommendations?

I am far from an expert, but I'd be happy to help if there's something I ca=
n do.
