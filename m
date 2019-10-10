Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77692D1F36
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 06:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfJJEIx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 00:08:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42899 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfJJEIx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Oct 2019 00:08:53 -0400
Received: by mail-pg1-f196.google.com with SMTP id z12so2783240pgp.9;
        Wed, 09 Oct 2019 21:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:user-agent:date:from:to:cc:cc:subject:references
         :mime-version:content-disposition;
        bh=utXsGoMVGSgrVkxuMTNUGAN09Y0Z0VDxqobF+kpgtP4=;
        b=UrJ+DMKkzmBQBZaCObJEvMg2znGmsVD7lgxtaQ+69d+kUp2/ZWK0xd3l49BzDrgQc5
         ZqUEQVAUASCXZKovHhe92E+Wovs22/uzMkRbLasxZADSzB69pj1l9DV9Z3n0mBgvKMZc
         u8dAhQPp/ugXHvVQzzqOH1KBrWVpDqq7LD1rb8KSnKbNNWFXOlKxayllx0CnfDL7TIkQ
         IXoEEU748I0JOYWgEgpvgLFFOvHf3aHq9MPCQQ1UxovnULraY1yPQFiNwJcHeMl8NOt1
         vwCr7rCUc9C8RiTZp+WyBIRsqYnJe2MDOrIZdhhN6nOZNBSUn9IjKOo9QjdkJHYpoWBN
         J7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:user-agent:date:from:to:cc:cc:subject
         :references:mime-version:content-disposition;
        bh=utXsGoMVGSgrVkxuMTNUGAN09Y0Z0VDxqobF+kpgtP4=;
        b=OCi4t3jicl7FKWsE0r+TsGItvE8LWL0Gwk9woEeS6uIwUHzaKsBU74Q5ArRLZVJf1Y
         NWC8uNCYDXtAcIrpM/7hgt+TouUVo5MkpIeG+0lnevHEWfZHdurQqYuZ/MRWp00nKUDE
         PWQHwFlSIy6itcD98BUh9OgthDGacT+2OwFRZyl9KnToSyFaQ4P+r1vFks2AoEvkaEVW
         v4sBTmuKokPwf/E3WMHtPBOrsKgYU/kwX6/d/1zmsgyofei/hYgUQF+D037d4rgKyJxP
         7iMm3FsnXvzktaF5F/66klOs4JcNch0O+N1wEWr2tIlRbc/xQ5Yhx4MrZv7YPh2NFb6N
         it/g==
X-Gm-Message-State: APjAAAVHVDQKYNZbiLpU2eY7uh28izhP9W+Wwf1eybQMVZeJqECOxC8V
        io/fDP65QcbCxEHN0dhlGYqGkSkT
X-Google-Smtp-Source: APXvYqxWpwRU2n05UtULPPRSvGDMU+l51GudNWk6Eet2gQlspE4NoLT/Iup60Z509qvepRfTnFph1A==
X-Received: by 2002:a17:90a:fd83:: with SMTP id cx3mr8497879pjb.64.1570680530264;
        Wed, 09 Oct 2019 21:08:50 -0700 (PDT)
Received: from localhost ([2601:1c0:6280:3f0::9ef4])
        by smtp.gmail.com with ESMTPSA id o11sm3367122pgp.13.2019.10.09.21.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:08:49 -0700 (PDT)
Message-Id: <20191010035239.756365352@gmail.com>
User-Agent: quilt/0.65
Date:   Wed, 09 Oct 2019 20:52:42 -0700
From:   rd.dunlab@gmail.com
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 03/12] infiniband: fix ulp/iser/iscsi_iser.h kernel-doc warnings
References: <20191010035239.532908118@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=008-iband-iscsi-iserhdr.patch
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix kernel-doc warnings and typos/spellos.

../drivers/infiniband/ulp/iser/iscsi_iser.h:254: warning: Function parameter or member 'dma_addr' not described in 'iser_tx_desc'
../drivers/infiniband/ulp/iser/iscsi_iser.h:254: warning: Function parameter or member 'cqe' not described in 'iser_tx_desc'
../drivers/infiniband/ulp/iser/iscsi_iser.h:254: warning: Function parameter or member 'reg_wr' not described in 'iser_tx_desc'
../drivers/infiniband/ulp/iser/iscsi_iser.h:254: warning: Function parameter or member 'send_wr' not described in 'iser_tx_desc'
../drivers/infiniband/ulp/iser/iscsi_iser.h:254: warning: Function parameter or member 'inv_wr' not described in 'iser_tx_desc'
../drivers/infiniband/ulp/iser/iscsi_iser.h:277: warning: Function parameter or member 'cqe' not described in 'iser_rx_desc'
../drivers/infiniband/ulp/iser/iscsi_iser.h:296: warning: Function parameter or member 'rsp' not described in 'iser_login_desc'
../drivers/infiniband/ulp/iser/iscsi_iser.h:339: warning: Function parameter or member 'reg_mem' not described in 'iser_reg_ops'
../drivers/infiniband/ulp/iser/iscsi_iser.h:399: warning: Function parameter or member 'all_list' not described in 'iser_fr_desc'
../drivers/infiniband/ulp/iser/iscsi_iser.h:413: warning: Function parameter or member 'all_list' not described in 'iser_fr_pool'
../drivers/infiniband/ulp/iser/iscsi_iser.h:439: warning: Function parameter or member 'reg_cqe' not described in 'ib_conn'
../drivers/infiniband/ulp/iser/iscsi_iser.h:491: warning: Function parameter or member 'snd_w_inv' not described in 'iser_conn'

This leaves 2 "member not described" warnings that I don't know how to fix:

../drivers/infiniband/ulp/iser/iscsi_iser.h:401: warning: Function parameter or member 'all_list' not described in 'iser_fr_desc'
../drivers/infiniband/ulp/iser/iscsi_iser.h:415: warning: Function parameter or member 'all_list' not described in 'iser_fr_pool'

Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-doc@vger.kernel.org
---
 drivers/infiniband/ulp/iser/iscsi_iser.h |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- linux-next-20191009.orig/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ linux-next-20191009/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -228,15 +228,16 @@ enum iser_desc_type {
  * @iser_header:   iser header
  * @iscsi_header:  iscsi header
  * @type:          command/control/dataout
- * @dam_addr:      header buffer dma_address
+ * @dma_addr:      header buffer dma_address
  * @tx_sg:         sg[0] points to iser/iscsi headers
  *                 sg[1] optionally points to either of immediate data
  *                 unsolicited data-out or control
  * @num_sge:       number sges used on this TX task
+ * @cqe:           completion handler
  * @mapped:        Is the task header mapped
- * reg_wr:         registration WR
- * send_wr:        send WR
- * inv_wr:         invalidate WR
+ * @reg_wr:        registration WR
+ * @send_wr:       send WR
+ * @inv_wr:        invalidate WR
  */
 struct iser_tx_desc {
 	struct iser_ctrl             iser_header;
@@ -263,6 +264,7 @@ struct iser_tx_desc {
  * @data:          received data segment
  * @dma_addr:      receive buffer dma address
  * @rx_sg:         ib_sge of receive buffer
+ * @cqe:           completion handler
  * @pad:           for sense data TODO: Modify to maximum sense length supported
  */
 struct iser_rx_desc {
@@ -279,9 +281,9 @@ struct iser_rx_desc {
  * struct iser_login_desc - iSER login descriptor
  *
  * @req:           pointer to login request buffer
- * @resp:          pointer to login response buffer
+ * @rsp:           pointer to login response buffer
  * @req_dma:       DMA address of login request buffer
- * @rsp_dma:      DMA address of login response buffer
+ * @rsp_dma:       DMA address of login response buffer
  * @sge:           IB sge for login post recv
  * @cqe:           completion handler
  */
@@ -316,7 +318,7 @@ struct iser_comp {
  *
  * @alloc_reg_res:     Allocate registration resources
  * @free_reg_res:      Free registration resources
- * @fast_reg_mem:      Register memory buffers
+ * @reg_mem:           Register memory buffers
  * @unreg_mem:         Un-register memory buffers
  * @reg_desc_get:      Get a registration descriptor for pool
  * @reg_desc_put:      Get a registration descriptor to pool
@@ -423,6 +425,7 @@ struct iser_fr_pool {
  * @comp:                iser completion context
  * @fr_pool:             connection fast registration poool
  * @pi_support:          Indicate device T10-PI support
+ * @reg_cqe:             completion handler
  */
 struct ib_conn {
 	struct rdma_cm_id           *cma_id;
@@ -463,6 +466,7 @@ struct ib_conn {
  * @num_rx_descs:     number of rx descriptors
  * @scsi_sg_tablesize: scsi host sg_tablesize
  * @pages_per_mr:     maximum pages available for registration
+ * @snd_w_inv:        connection uses remote invalidation
  */
 struct iser_conn {
 	struct ib_conn		     ib_conn;


