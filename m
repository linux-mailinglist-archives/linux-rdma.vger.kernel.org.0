Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23E8013F726
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 20:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbgAPTJm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 14:09:42 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34022 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387877AbgAPRAo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 12:00:44 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so9371688qvf.1
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 09:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AxmqBUiv5wNimdTdQeCsjl/tKrGwo3/M4S4zbYLLGuw=;
        b=nrjDpZFSwsc1R6r1vkgcKsbaDAAmCAl2FrTN0f1r385zJIryJu3Iw1am2m5ICrHem7
         Btj7CpYLID+CI3GzGOO20riSilLC3bDOwNVdRAa8vIYu2v9zVdn8KmlghU8aQ+FoaGkh
         Etfj3kWKGncRkQFXJwu3f6BvIA+zq8IWQaeRpMq7s4F/Bq11aUm/piEWnW+xa+xCp4yE
         cnpK2mHJp1kPpcgH1AON0L7Ll9LdTa377lQAOlZEt/M0Pzjs0+8yIbMZhU8KNo7J9WQ5
         jgieVXqBoeD8Pi+UkFWmz7ayBBn6tmYTyeI8E7L+VUV3ikrq78d3xsUsuaMtZtamkTgW
         r+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AxmqBUiv5wNimdTdQeCsjl/tKrGwo3/M4S4zbYLLGuw=;
        b=GNIPeww4/agzD2i3uG10EwObOJiSmxuqVltEm4PfMCPsdXct8N2yoPKIqgtPkvvTQv
         fnb9JFktLXN/YU2i78qmhNbygSZ3G4KxNPKjXzaG7pfIPHRQhcvD303KrJnvtY92Dp+U
         HtcOmI9P6Dt0ybHonsz8vAeAwCCTcx3yGRCut4i94zUn7j2/rC9BpcdWhs7B6U0tp82F
         zjvr0ONnCTs2O33OIJx8UN3vf/K3wzpiK6tyAZrIPkiZt853xUENk/yO76IbeC4yoZZa
         KNOz07yNBdNEW9fDMzCkNzonkE4Q2pyO8f0QJWMkkkQCGEpS3es+Kph6XRKa64nPkkjA
         LGvQ==
X-Gm-Message-State: APjAAAWYwwlbvU2JvHpcYjtbugdBT0AKzrFovTdAnUdRxx1NvfOC0gjk
        9TutYJaDWFEPPHrEtR1IE7EiMGz0Pfk=
X-Google-Smtp-Source: APXvYqydHpiiKZNPSKZu3rTbFLfdoEnVFNVZV22wPMGGWIboj7mGxUrPnfBLj4zxw/sfYrtCFZHyXA==
X-Received: by 2002:ad4:46c3:: with SMTP id g3mr3418348qvw.60.1579194042003;
        Thu, 16 Jan 2020 09:00:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id f26sm11358499qtv.77.2020.01.16.09.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 09:00:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1is8Vb-0007t6-Us; Thu, 16 Jan 2020 13:00:39 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 0/7] RDMA/cm: Remove open coded structure pack/unpack
Date:   Thu, 16 Jan 2020 13:00:30 -0400
Message-Id: <20200116170037.30109-1-jgg@ziepe.ca>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Instead of using a struct layout with a large number of open coded pack/unpack
inlines use a consistent set of macros generating GENMASK's for accessing the
members. The definitions follow the MAD layout tables in the IBA and are easier
to correlate with the specification.

Further the macros consistently use cpu endian values which will allow later
patches to remove alot of the __be stuff sprinkled randomly around.

The is a follow up to the series here:

https://lore.kernel.org/r/20191212093830.316934-1-leon@kernel.org

Jason Gunthorpe (6):
  RDMA/cm: Add accessors for CM_REQ transport_type
  RDMA/cm: Use IBA functions for simple get/set acessors
  RDMA/cm: Use IBA functions for swapping get/set acessors
  RDMA/cm: Use IBA functions for simple structure members
  RDMA/cm: Use IBA functions for complex structure members
  RDMA/cm: Remove CM message structs

Leon Romanovsky (1):
  RDMA/cm: Add SET/GET implementations to hide IBA wire format

 drivers/infiniband/core/cm.c      | 793 ++++++++++++++++++------------
 drivers/infiniband/core/cm_msgs.h | 685 +-------------------------
 include/rdma/iba.h                | 146 ++++++
 include/rdma/ibta_vol1_c12.h      | 213 ++++++++
 4 files changed, 852 insertions(+), 985 deletions(-)
 create mode 100644 include/rdma/iba.h
 create mode 100644 include/rdma/ibta_vol1_c12.h

-- 
2.24.1

