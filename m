Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D6C32A79
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2019 10:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfFCIJp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jun 2019 04:09:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:43407 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfFCIJp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Jun 2019 04:09:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 01:09:45 -0700
X-ExtLoop1: 1
Received: from jerryopenix.sh.intel.com (HELO jerryopenix) ([10.239.158.171])
  by orsmga001.jf.intel.com with ESMTP; 03 Jun 2019 01:09:44 -0700
Date:   Mon, 3 Jun 2019 16:08:40 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Difference: VPI verbs API & RDMA_CM verbs API
Message-ID: <20190603080840.GA14648@jerryopenix>
References: <20190602120303.GA20100@jerryopenix>
 <20190603074807.GI5261@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190603074807.GI5261@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Leon Romanovksy,
 Could I think it like below? I'm wondering how to use RDMA_CM API to make IB/RoCEv1 device work.
   1) VPI provides lower layer control API for the devices which implement IB/RoCEv1/RoCEv2/iWARP
   2) RDMA_CM use parts of VPI and other library API to make it convenient to use the devices which implement RoCEv2/iWARP
 For exmaple, rdma_get_devices do some extra things e.g. ucma_set_af_ib_support, besides calling ibv_open_device.

B.R.
Changcheng

On 10:48 Mon 03 Jun, Leon Romanovsky wrote:
> On Sun, Jun 02, 2019 at 08:03:04PM +0800, Liu, Changcheng wrote:
> > Hi All,
> >     Does anyone know the difference between “VPI verbs API” & “RDMA_CM verbs API”?
> >     Is there limitation for these two kinds of API to be used for IB/RoCEv1/RoCEv2/iWARP?
> 
> RDMA_CM verbs provide subset of VPI verbs, because they are implemented
> on top of those VPI verbs.
> 
> Thanks
> 
> >
> > B.R.
> > Changcheng
