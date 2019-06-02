Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A476032332
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2019 14:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfFBMEJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 2 Jun 2019 08:04:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:32165 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfFBMEJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 2 Jun 2019 08:04:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jun 2019 05:04:08 -0700
X-ExtLoop1: 1
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.171])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jun 2019 05:04:07 -0700
Date:   Sun, 2 Jun 2019 20:03:04 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     linux-rdma@vger.kernel.org
Subject: Difference: VPI verbs API & RDMA_CM verbs API
Message-ID: <20190602120303.GA20100@jerryopenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi All,
    Does anyone know the difference between “VPI verbs API” & “RDMA_CM verbs API”?
    Is there limitation for these two kinds of API to be used for IB/RoCEv1/RoCEv2/iWARP?

B.R.
Changcheng
