Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 116DA19C892
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Apr 2020 20:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733055AbgDBSMn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Apr 2020 14:12:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43520 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBSMn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Apr 2020 14:12:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id 91so3433144wri.10
        for <linux-rdma@vger.kernel.org>; Thu, 02 Apr 2020 11:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fsRVXHkmr2xYJyphQ6o9w3C892TgKKQIOYnW0JPFZ+4=;
        b=Bz65KnS+TAVLDNGOu+D3tPIigtewFpN7jWkhRyid1idiqeWjVA8+aENdzAF/87AeDu
         XpIMGQ5/IkN2ja9AwrnFs3fvSl6pLnfZKwzNVa0CpzQTWLDSAgFQlOjyL/6LLHRzx9RK
         45t/QWssqwJloOrrwvyutTAdFAlxor4B3RGi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fsRVXHkmr2xYJyphQ6o9w3C892TgKKQIOYnW0JPFZ+4=;
        b=R7rDSlOuB/Rwu4FDvlCEn/2w8KgcQRTEOKHFZduj8OD+/f4kTlUIMpgagH9SEfFW/A
         xGSXiKT9A/hYr5QxKoKwDjKL8p4LG/1nixX56Srxv804mfFeRA6ejw6b2RnEUMqKjmel
         YnY7zRauve5wjhoOPJKpmKuxvf1Rz4z4aUvDBMdQ7uV5ClxZv6fZu9tQom8wHwzrUT0A
         5FfD1FkxIQqFn6EHAl7C0fDyetBNyO1Zm9jPyY5uhzsHqyg/50N59ZQ/47hJOB+efbeW
         kfQzXmfkcMZhE17zkwGLwMZFY4jvMR/FpekxbfSBugnRENDaed5jXzFQbB+ZM6QH2xKT
         oxrQ==
X-Gm-Message-State: AGi0PuYjbMNtHQobHKdlo64y6if2m0OOOEqd3lBMnsYHsO86/0tPHsRD
        Jv/Es20k9k1/dhDMZfZcppYxRdvoEnlUtfqjWaIcxalsnruCPOaHRBHnkRZ54knSpEMSylTqmLg
        xs2BLicZDqNzSO6ktsBy7VJkknh4v6s39swGl1sL5qFQYNKBRpWYNFrT7lCyo3qTGMqso8OQpxL
        NGyC0=
X-Google-Smtp-Source: APiQypKRfXkZwtPDRbbQF+w/Ce8BP1svPlpj5i+sRLPx6MMxKGeLHr3Vh9+YPOSUSWch2G7nx/ZyjQ==
X-Received: by 2002:adf:b35e:: with SMTP id k30mr4625808wrd.362.1585851160798;
        Thu, 02 Apr 2020 11:12:40 -0700 (PDT)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k3sm8399351wro.39.2020.04.02.11.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 11:12:40 -0700 (PDT)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [internal PATCH for-next 0/4] further improvements to bnxt_re driver
Date:   Thu,  2 Apr 2020 14:12:16 -0400
Message-Id: <1585851136-2316-6-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585851136-2316-1-git-send-email-devesh.sharma@broadcom.com>
References: <1585851136-2316-1-git-send-email-devesh.sharma@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This short patch series is an extension to the previous
refactor series. The main pourpose of these patches is to
streamline the queue management code in slightly better
way.

Devesh Sharma (4):
  RDMA/bnxt_re: reduce device page size detection code
  RDMA/bnxt_re: Update missing hsi data structures
  RDMA/bnxt_re: simplify obtaining queue entry from hw ring
  RDMA/bnxt_re: Remove dead code from rcfw

 drivers/infiniband/hw/bnxt_re/ib_verbs.c   |  65 +++---
 drivers/infiniband/hw/bnxt_re/ib_verbs.h   |  10 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 354 ++++++++++++-----------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  42 +---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  88 +++----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  91 --------
 drivers/infiniband/hw/bnxt_re/qplib_res.c  |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h  |  47 ++++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h   | 106 +++++++++
 9 files changed, 379 insertions(+), 425 deletions(-)

-- 
1.8.3.1

