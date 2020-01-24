Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF8B2147850
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jan 2020 06:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgAXFwx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jan 2020 00:52:53 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33345 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAXFwx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 24 Jan 2020 00:52:53 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so337394plb.0
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jan 2020 21:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZfdkyF037na11WdCTJGSSaJVYZ0qyQobrI4cOtQzvWg=;
        b=iATLIDAmmkeRL/lT8JEaxCKTmOhq4ediNn1h1EbXThOkB3ehC5CahqJUNNujFCgpox
         32A06zJPe8GZMbqHV7Xl8WpKKgfML4kPkkdqeGQvVBMKL5s3hi3niuhkMh0C+WL7vYLJ
         bKYfvw/bZmB83SKP0QrcvowzM+FiYSk9HJ1qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZfdkyF037na11WdCTJGSSaJVYZ0qyQobrI4cOtQzvWg=;
        b=hDisFxpklgjnIUbGki3DJV2wsEwEJsbq3QZjDYXiXB65GfV9v38wL99177pztV4hHW
         egmVQ6Pe2x4e7lAFpcI/z4EiLc/aMKXi4FH6w7tLDgyzd5oLLkzpP5YqPdbKf2GYY1F8
         E2Fogsf9VP0EnNkSYskJpQa2t9NFoOWUzxjXzRcWHUp8mRgA2+POiYshxIltv+qV7Haf
         HtbGl2EW9ClmWELkamPTGWedLmQzMDMTpxsLKfY5SzGKIduq78Mx+HoEyH/qsirbJyz6
         el4JLDWJVqBvV7m4ef+uVmMFmWtx3yGtzMtIyPH/+Rz++Wh1G1KdIgBVHmCUR9zqRAhR
         pcEQ==
X-Gm-Message-State: APjAAAWPuQXyy7gSb3ahtahpwurFP9oXyu2/nf19hVV50xljs0/E5Qlt
        zpZolseJJEV0usjmdOMsh2N8UKg0ykLEiJehSMp183MHTUtFvBG9jj0UOgSBNCsU0UK5ZkE0wmJ
        iekLE//7XWiL3b0KBCeoObTO+lYrki6rjXPgAI+9PW0IPdOAde3BZc06o0eSePOcaw9sNYS7Nep
        vP25zWVA==
X-Google-Smtp-Source: APXvYqyQivTNMsl/rlPYJBPQ/WUmmbFgEF5yGUpuXJO3mOy+uIyD7XZVqiKn4igD6IaDA2n5pl52VQ==
X-Received: by 2002:a17:902:bd87:: with SMTP id q7mr1893613pls.239.1579845172474;
        Thu, 23 Jan 2020 21:52:52 -0800 (PST)
Received: from neo00-el73.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r20sm4781024pgu.89.2020.01.23.21.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 21:52:52 -0800 (PST)
From:   Devesh Sharma <devesh.sharma@broadcom.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@mellanox.com, dledford@redhat.com
Subject: [PATCH for-next 0/7] Refactor control path of bnxt_re driver
Date:   Fri, 24 Jan 2020 00:52:38 -0500
Message-Id: <1579845165-18002-1-git-send-email-devesh.sharma@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is the first series out of few more forthcoming series to refactor
Broadcom's RoCE driver. This series contains patches to refactor control
path. Since this is first series, there may be few code section which may
look redundant or overkill but those will be taken care in future patche
series.

These patches apply clean on tip of for-next branch.
Each patch in this series is tested against user and kernel functionality.

Devesh Sharma (7):
  RDMA/bnxt_re: Refactor queue pair creation code
  RDMA/bnxt_re: Replace chip context structure with pointer
  RDMA/bnxt_re: Refactor hardware queue memory allocation
  RDMA/bnxt_re: Refactor net ring allocation function
  RDMA/bnxt_re: Refactor command queue management code
  RDMA/bnxt_re: Refactor notification queue management code
  RDMA/bnxt_re: Refactor doorbell management functions

 drivers/infiniband/hw/bnxt_re/bnxt_re.h    |  24 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 670 +++++++++++++++++++----------
 drivers/infiniband/hw/bnxt_re/main.c       | 134 +++---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 423 +++++++++---------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  94 ++--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 474 ++++++++++++--------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  85 ++--
 drivers/infiniband/hw/bnxt_re/qplib_res.c  | 475 ++++++++++++--------
 drivers/infiniband/hw/bnxt_re/qplib_res.h  | 145 ++++++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   |  52 ++-
 10 files changed, 1579 insertions(+), 997 deletions(-)

-- 
1.8.3.1

