Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61945D1F30
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 06:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfJJEIf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 00:08:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43295 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfJJEIe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Oct 2019 00:08:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so3000479pfo.10;
        Wed, 09 Oct 2019 21:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:user-agent:date:from:to:cc:cc:subject;
        bh=uSCgIQ4b5P3WH4lz0cFe8247i5uPiz/jkdyyNGLEv2k=;
        b=bWFMWh0QVw8aq9StQZyW1vP87IkIpgsKfii8nhSLor99O9M9xooSmlaxOoy0y7+5S0
         xJsjTR2O1y3+AayBF5XHow0ar/MbRaeboBfqX3PdAC1aaAP6dCHLPPfqYlJXuQkngrgl
         wz/Ct+Gi5kDIVA3RKbcB2xYH1yFaFh8O0dtqhhWSEVXCnQ+Tj0pmDC7tN1FpDJ6qfMrD
         OevhErcWLcZ8Xc3qJRo9JCBseXXSClB3ZhndEo6ZyHQPA7dOEkKqap2OYObz36udytKH
         mkGxvJX7E4imHPOmaB7ADL0uQrTCouFN2udFoHGfJzcTJ7aZ40iWpFqovp+9Y0Egsgqc
         npVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:user-agent:date:from:to:cc:cc:subject;
        bh=uSCgIQ4b5P3WH4lz0cFe8247i5uPiz/jkdyyNGLEv2k=;
        b=VLzWL0fROt/mgojptDR9ttR3ozzqSxUPXnsKsx3FNJxILIA42dSQNzEkqxMBzimAQx
         rj4Ef8IeP8xTHJdozF5N6W0UijeADkyIn6JREMsfQzgkHETwZlo6I3kSqmh6Zni8dRap
         Q5Wanv3tlnWSxVUZ0xYspbAxB/jJVjYn0RswFG/hzZqeOnS8ttuimC6irnSCk++o9zbu
         /sQFP0oc1dzeNnyw+FBzvyR+yALpxfhXsjJSYaTOQiX8N9+rNItDALtTHBAFOxrqOC/E
         ZHW1AzbSg4Mf9QDPHnACMgItZXkZr6WebguJcODcZlHVX05MyRO/t/0lOH9wc4pW2hrn
         0TXw==
X-Gm-Message-State: APjAAAUo+eOGdKqxj/jumWm4x7Q7F2QLAd73dpnEf4K+LXNEi87vYZJX
        jF/fb192ahAouGoJ10JCx+NxvRMm
X-Google-Smtp-Source: APXvYqzCjcGmzPmvnZl6iR3ReUl4vOWbYHDK9wxxnzJT99zKS38T2oA6i8rFSMdgNcrQITKq6GKvVw==
X-Received: by 2002:a62:2f05:: with SMTP id v5mr7518455pfv.79.1570680512103;
        Wed, 09 Oct 2019 21:08:32 -0700 (PDT)
Received: from localhost ([2601:1c0:6280:3f0::9ef4])
        by smtp.gmail.com with ESMTPSA id k5sm5267229pgb.11.2019.10.09.21.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:08:31 -0700 (PDT)
Message-Id: <20191010035239.532908118@gmail.com>
User-Agent: quilt/0.65
Date:   Wed, 09 Oct 2019 20:52:39 -0700
From:   rd.dunlab@gmail.com
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 00/12] infiniband kernel-doc fixes & driver-api/ chapter
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


This patch series cleans up lots of kernel-doc in drivers/infiniband/
and then adds an infiniband.rst file.

It also changes a few instances of non-exported functions from kernel-doc
notation back to non-kernel-doc comments.

There are still a few kernel-doc and Sphinx warnings that I don't know how
to resolve:

  ../drivers/infiniband/ulp/iser/iscsi_iser.h:401: warning: Function parameter or member 'all_list' not described in 'iser_fr_desc'
  ../drivers/infiniband/ulp/iser/iscsi_iser.h:415: warning: Function parameter or member 'all_list' not described in 'iser_fr_pool'
  ../drivers/infiniband/core/verbs.c:2510: WARNING: Unexpected indentation.
  ../drivers/infiniband/core/verbs.c:2512: WARNING: Block quote ends without a blank line; unexpected unindent.
  ../drivers/infiniband/core/verbs.c:2544: WARNING: Unexpected indentation.

I have not added any Fixes: tags to these patches because I don't
think that they need to be applied to any stable releases...


 Documentation/driver-api/index.rst                  |    1 
 Documentation/driver-api/infiniband.rst             |  127 ++++++++++
 drivers/infiniband/core/device.c                    |   23 -
 drivers/infiniband/core/iwpm_util.h                 |    5 
 drivers/infiniband/core/sa_query.c                  |    2 
 drivers/infiniband/core/verbs.c                     |    2 
 drivers/infiniband/sw/rdmavt/ah.c                   |    1 
 drivers/infiniband/sw/rdmavt/cq.c                   |    2 
 drivers/infiniband/sw/rdmavt/qp.c                   |   30 +-
 drivers/infiniband/sw/rdmavt/vt.c                   |    3 
 drivers/infiniband/ulp/iser/iscsi_iser.c            |    2 
 drivers/infiniband/ulp/iser/iscsi_iser.h            |   26 +-
 drivers/infiniband/ulp/iser/iser_initiator.c        |    5 
 drivers/infiniband/ulp/iser/iser_verbs.c            |   60 ++--
 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h    |   42 +++
 drivers/infiniband/ulp/opa_vnic/opa_vnic_internal.h |    8 
 drivers/infiniband/ulp/srpt/ib_srpt.h               |    7 
 17 files changed, 269 insertions(+), 77 deletions(-)


