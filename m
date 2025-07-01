Return-Path: <linux-rdma+bounces-11801-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368F5AEFAC9
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 15:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3FB4E15B1
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jul 2025 13:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2267227703C;
	Tue,  1 Jul 2025 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HAEfbjpm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6FC277011
	for <linux-rdma@vger.kernel.org>; Tue,  1 Jul 2025 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376586; cv=none; b=nM4QKu7WNqTaN/jkSwIIqyDBMlFEbC+q5HN9YDBLBUtg69mZfc/oWy05eU65Ept94ag/r+PB3Jm9/BY3P4rX5GmHu+PlaF+Yy3rJHH59PfdCx2p9YCbG8A18aTZ9JiMe0AESp9CN+lNqzxQh0w6fG+E40LxUxRSHmeb6+Kmgmxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376586; c=relaxed/simple;
	bh=dJZb+0Tgr/+2enRX+lplwKdZP4jqOLytX/EHtvltEdg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g+ywlosAXjHmh5XOpOCOh6S1koYlca7ByYVXaxMuilIw2Kp/LYDOi9rGkWJdtd33j4Tpkq+BCsAyc3jCqtTCmxJxNhu2eAahL2ffGgH3BpMAHZSC7q6CoR2ClRSboVh4mG579TzKSFfES/kBmMWdSdVPWjgZ2xhZ5BDXAEKBe9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HAEfbjpm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751376585; x=1782912585;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dJZb+0Tgr/+2enRX+lplwKdZP4jqOLytX/EHtvltEdg=;
  b=HAEfbjpmUA1iyOf0gSHHyGUMosR9u8ousZ47YlXraegmSNMI8FSiX1eT
   bDGBs0KFvPHspfiR0MXyA8ygjwbgW316CIA5HviWM6+cFtqK9QLtva/pT
   vN3fHcA7Q7a2Rh4YdZa8T3z1EKVgn3deZ1Vf9GGOStlgIZWdd7X+sv0Qn
   ydliIyBJhyEHwf6unc9zP4La261agvt6o/+aFCmlGZYcWFA/TjPbxAPut
   AUA9RoCTRLfveyJAq3Ews2oNNf+X0Ut+rtWZy8vqJ2nlq06F9gykYfYHq
   ObnH8DIEamFsSfR4usKJeexC3H6xkenzaX1s0K28d+wq3Aa6KepaNMYD4
   A==;
X-CSE-ConnectionGUID: Ha5zbeGXRBOTr8xRMHHlgw==
X-CSE-MsgGUID: ZC28I6/ESROgbGP2HKNu8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="76189781"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="76189781"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 06:29:45 -0700
X-CSE-ConnectionGUID: CQFMUu9vR0uBTX9BFC3DtA==
X-CSE-MsgGUID: w9pT2TXgToeVTWmEJuj+zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="159484892"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 01 Jul 2025 06:29:42 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWb3M-000aD0-09;
	Tue, 01 Jul 2025 13:29:40 +0000
Date: Tue, 1 Jul 2025 21:28:52 +0800
From: kernel test robot <lkp@intel.com>
To: Parav Pandit <parav@nvidia.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Doug Ledford <dledford@redhat.com>,
	Jason Gunthorpe <jgg+lists@ziepe.ca>, linux-rdma@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>
Subject: [rdma:wip/leon-for-next 22/26]
 drivers/infiniband/core/uverbs_cmd.c:1317:2: warning: unannotated
 fall-through between switch labels
Message-ID: <202507012130.wj8uTvPl-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git wip/leon-for-next
head:   4d67f2ac89a89271047598f7486f9c4494b79799
commit: c961a341c2c2c24961d6034afa9f021c6744d45c [22/26] RDMA/uverbs: Check CAP_NET_RAW in user namespace for RAW QP create
config: i386-buildonly-randconfig-006-20250701 (https://download.01.org/0day-ci/archive/20250701/202507012130.wj8uTvPl-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250701/202507012130.wj8uTvPl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507012130.wj8uTvPl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/infiniband/core/uverbs_cmd.c:1317:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    1317 |         case IB_QPT_RC:
         |         ^
   drivers/infiniband/core/uverbs_cmd.c:1317:2: note: insert 'break;' to avoid fall-through
    1317 |         case IB_QPT_RC:
         |         ^
         |         break; 
   1 warning generated.


vim +1317 drivers/infiniband/core/uverbs_cmd.c

bc38a6abdd5a50 Roland Dreier      2005-07-07  1294  
8313c10fa8be03 Jason Gunthorpe    2018-11-25  1295  static int create_qp(struct uverbs_attr_bundle *attrs,
ece9ca97ccdc84 Jason Gunthorpe    2018-11-25  1296  		     struct ib_uverbs_ex_create_qp *cmd)
bc38a6abdd5a50 Roland Dreier      2005-07-07  1297  {
9ead190bfde2a4 Roland Dreier      2006-06-17  1298  	struct ib_uqp_object		*obj;
b93f3c18727634 Sean Hefty         2011-05-27  1299  	struct ib_device		*device;
b93f3c18727634 Sean Hefty         2011-05-27  1300  	struct ib_pd			*pd = NULL;
b93f3c18727634 Sean Hefty         2011-05-27  1301  	struct ib_xrcd			*xrcd = NULL;
fd3c7904db6e05 Matan Barak        2017-04-04  1302  	struct ib_uobject		*xrcd_uobj = ERR_PTR(-ENOENT);
b93f3c18727634 Sean Hefty         2011-05-27  1303  	struct ib_cq			*scq = NULL, *rcq = NULL;
9977f4f64bfeb5 Sean Hefty         2011-05-26  1304  	struct ib_srq			*srq = NULL;
bc38a6abdd5a50 Roland Dreier      2005-07-07  1305  	struct ib_qp			*qp;
c70285f880e88c Yishai Hadas       2016-05-23  1306  	struct ib_qp_init_attr		attr = {};
16e51f78a9db36 Leon Romanovsky    2020-07-19  1307  	struct ib_uverbs_ex_create_qp_resp resp = {};
bc38a6abdd5a50 Roland Dreier      2005-07-07  1308  	int				ret;
c70285f880e88c Yishai Hadas       2016-05-23  1309  	struct ib_rwq_ind_table *ind_tbl = NULL;
c70285f880e88c Yishai Hadas       2016-05-23  1310  	bool has_sq = true;
bbd51e881ff05a Jason Gunthorpe    2018-07-25  1311  	struct ib_device *ib_dev;
bc38a6abdd5a50 Roland Dreier      2005-07-07  1312  
5807bb32055bb8 Leon Romanovsky    2020-09-26  1313  	switch (cmd->qp_type) {
5807bb32055bb8 Leon Romanovsky    2020-09-26  1314  	case IB_QPT_RAW_PACKET:
c961a341c2c2c2 Parav Pandit       2025-06-26  1315  		if (!rdma_uattrs_has_raw_cap(attrs))
c938a616aadb62 Or Gerlitz         2012-03-01  1316  			return -EPERM;
5807bb32055bb8 Leon Romanovsky    2020-09-26 @1317  	case IB_QPT_RC:
5807bb32055bb8 Leon Romanovsky    2020-09-26  1318  	case IB_QPT_UC:
5807bb32055bb8 Leon Romanovsky    2020-09-26  1319  	case IB_QPT_UD:
5807bb32055bb8 Leon Romanovsky    2020-09-26  1320  	case IB_QPT_XRC_INI:
5807bb32055bb8 Leon Romanovsky    2020-09-26  1321  	case IB_QPT_XRC_TGT:
5807bb32055bb8 Leon Romanovsky    2020-09-26  1322  	case IB_QPT_DRIVER:
5807bb32055bb8 Leon Romanovsky    2020-09-26  1323  		break;
5807bb32055bb8 Leon Romanovsky    2020-09-26  1324  	default:
5807bb32055bb8 Leon Romanovsky    2020-09-26  1325  		return -EINVAL;
5807bb32055bb8 Leon Romanovsky    2020-09-26  1326  	}
c938a616aadb62 Or Gerlitz         2012-03-01  1327  
8313c10fa8be03 Jason Gunthorpe    2018-11-25  1328  	obj = (struct ib_uqp_object *)uobj_alloc(UVERBS_OBJECT_QP, attrs,
bbd51e881ff05a Jason Gunthorpe    2018-07-25  1329  						 &ib_dev);
fd3c7904db6e05 Matan Barak        2017-04-04  1330  	if (IS_ERR(obj))
fd3c7904db6e05 Matan Barak        2017-04-04  1331  		return PTR_ERR(obj);
fd3c7904db6e05 Matan Barak        2017-04-04  1332  	obj->uxrcd = NULL;
fd3c7904db6e05 Matan Barak        2017-04-04  1333  	obj->uevent.uobject.user_handle = cmd->user_handle;
f48b726920d96d Matan Barak        2017-04-04  1334  	mutex_init(&obj->mcast_lock);
bc38a6abdd5a50 Roland Dreier      2005-07-07  1335  
ece9ca97ccdc84 Jason Gunthorpe    2018-11-25  1336  	if (cmd->comp_mask & IB_UVERBS_CREATE_QP_MASK_IND_TABLE) {
2cc1e3b80942a7 Jason Gunthorpe    2018-07-04  1337  		ind_tbl = uobj_get_obj_read(rwq_ind_table,
2cc1e3b80942a7 Jason Gunthorpe    2018-07-04  1338  					    UVERBS_OBJECT_RWQ_IND_TBL,
8313c10fa8be03 Jason Gunthorpe    2018-11-25  1339  					    cmd->rwq_ind_tbl_handle, attrs);
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1340  		if (IS_ERR(ind_tbl)) {
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1341  			ret = PTR_ERR(ind_tbl);
c70285f880e88c Yishai Hadas       2016-05-23  1342  			goto err_put;
c70285f880e88c Yishai Hadas       2016-05-23  1343  		}
c70285f880e88c Yishai Hadas       2016-05-23  1344  
c70285f880e88c Yishai Hadas       2016-05-23  1345  		attr.rwq_ind_tbl = ind_tbl;
c70285f880e88c Yishai Hadas       2016-05-23  1346  	}
c70285f880e88c Yishai Hadas       2016-05-23  1347  
c70285f880e88c Yishai Hadas       2016-05-23  1348  	if (ind_tbl && (cmd->max_recv_wr || cmd->max_recv_sge || cmd->is_srq)) {
c70285f880e88c Yishai Hadas       2016-05-23  1349  		ret = -EINVAL;
c70285f880e88c Yishai Hadas       2016-05-23  1350  		goto err_put;
c70285f880e88c Yishai Hadas       2016-05-23  1351  	}
c70285f880e88c Yishai Hadas       2016-05-23  1352  
c70285f880e88c Yishai Hadas       2016-05-23  1353  	if (ind_tbl && !cmd->max_send_wr)
c70285f880e88c Yishai Hadas       2016-05-23  1354  		has_sq = false;
bc38a6abdd5a50 Roland Dreier      2005-07-07  1355  
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1356  	if (cmd->qp_type == IB_QPT_XRC_TGT) {
1f7ff9d5d36ae1 Matan Barak        2018-03-19  1357  		xrcd_uobj = uobj_get_read(UVERBS_OBJECT_XRCD, cmd->pd_handle,
8313c10fa8be03 Jason Gunthorpe    2018-11-25  1358  					  attrs);
fd3c7904db6e05 Matan Barak        2017-04-04  1359  
fd3c7904db6e05 Matan Barak        2017-04-04  1360  		if (IS_ERR(xrcd_uobj)) {
fd3c7904db6e05 Matan Barak        2017-04-04  1361  			ret = -EINVAL;
fd3c7904db6e05 Matan Barak        2017-04-04  1362  			goto err_put;
fd3c7904db6e05 Matan Barak        2017-04-04  1363  		}
fd3c7904db6e05 Matan Barak        2017-04-04  1364  
fd3c7904db6e05 Matan Barak        2017-04-04  1365  		xrcd = (struct ib_xrcd *)xrcd_uobj->object;
b93f3c18727634 Sean Hefty         2011-05-27  1366  		if (!xrcd) {
b93f3c18727634 Sean Hefty         2011-05-27  1367  			ret = -EINVAL;
b93f3c18727634 Sean Hefty         2011-05-27  1368  			goto err_put;
b93f3c18727634 Sean Hefty         2011-05-27  1369  		}
b93f3c18727634 Sean Hefty         2011-05-27  1370  		device = xrcd->device;
b93f3c18727634 Sean Hefty         2011-05-27  1371  	} else {
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1372  		if (cmd->qp_type == IB_QPT_XRC_INI) {
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1373  			cmd->max_recv_wr = 0;
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1374  			cmd->max_recv_sge = 0;
9977f4f64bfeb5 Sean Hefty         2011-05-26  1375  		} else {
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1376  			if (cmd->is_srq) {
2cc1e3b80942a7 Jason Gunthorpe    2018-07-04  1377  				srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ,
8313c10fa8be03 Jason Gunthorpe    2018-11-25  1378  							cmd->srq_handle, attrs);
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1379  				if (IS_ERR(srq) ||
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1380  				    srq->srq_type == IB_SRQT_XRC) {
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1381  					ret = IS_ERR(srq) ? PTR_ERR(srq) :
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1382  								  -EINVAL;
9977f4f64bfeb5 Sean Hefty         2011-05-26  1383  					goto err_put;
9977f4f64bfeb5 Sean Hefty         2011-05-26  1384  				}
9977f4f64bfeb5 Sean Hefty         2011-05-26  1385  			}
5909ce545db415 Roland Dreier      2012-04-30  1386  
c70285f880e88c Yishai Hadas       2016-05-23  1387  			if (!ind_tbl) {
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1388  				if (cmd->recv_cq_handle != cmd->send_cq_handle) {
2cc1e3b80942a7 Jason Gunthorpe    2018-07-04  1389  					rcq = uobj_get_obj_read(
2cc1e3b80942a7 Jason Gunthorpe    2018-07-04  1390  						cq, UVERBS_OBJECT_CQ,
8313c10fa8be03 Jason Gunthorpe    2018-11-25  1391  						cmd->recv_cq_handle, attrs);
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1392  					if (IS_ERR(rcq)) {
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1393  						ret = PTR_ERR(rcq);
9ead190bfde2a4 Roland Dreier      2006-06-17  1394  						goto err_put;
bc38a6abdd5a50 Roland Dreier      2005-07-07  1395  					}
9977f4f64bfeb5 Sean Hefty         2011-05-26  1396  				}
5909ce545db415 Roland Dreier      2012-04-30  1397  			}
c70285f880e88c Yishai Hadas       2016-05-23  1398  		}
5909ce545db415 Roland Dreier      2012-04-30  1399  
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1400  		if (has_sq) {
2cc1e3b80942a7 Jason Gunthorpe    2018-07-04  1401  			scq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ,
8313c10fa8be03 Jason Gunthorpe    2018-11-25  1402  						cmd->send_cq_handle, attrs);
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1403  			if (IS_ERR(scq)) {
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1404  				ret = PTR_ERR(scq);
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1405  				goto err_put;
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1406  			}
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1407  		}
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1408  
efeb973ffce7f3 Xiao Yang          2020-12-16  1409  		if (!ind_tbl && cmd->qp_type != IB_QPT_XRC_INI)
5909ce545db415 Roland Dreier      2012-04-30  1410  			rcq = rcq ?: scq;
2cc1e3b80942a7 Jason Gunthorpe    2018-07-04  1411  		pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd->pd_handle,
8313c10fa8be03 Jason Gunthorpe    2018-11-25  1412  				       attrs);
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1413  		if (IS_ERR(pd)) {
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1414  			ret = PTR_ERR(pd);
5909ce545db415 Roland Dreier      2012-04-30  1415  			goto err_put;
5909ce545db415 Roland Dreier      2012-04-30  1416  		}
5909ce545db415 Roland Dreier      2012-04-30  1417  
b93f3c18727634 Sean Hefty         2011-05-27  1418  		device = pd->device;
b93f3c18727634 Sean Hefty         2011-05-27  1419  	}
bc38a6abdd5a50 Roland Dreier      2005-07-07  1420  
bc38a6abdd5a50 Roland Dreier      2005-07-07  1421  	attr.event_handler = ib_uverbs_qp_event_handler;
bc38a6abdd5a50 Roland Dreier      2005-07-07  1422  	attr.send_cq       = scq;
bc38a6abdd5a50 Roland Dreier      2005-07-07  1423  	attr.recv_cq       = rcq;
f520ba5aa48e28 Roland Dreier      2005-08-18  1424  	attr.srq           = srq;
b93f3c18727634 Sean Hefty         2011-05-27  1425  	attr.xrcd	   = xrcd;
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1426  	attr.sq_sig_type   = cmd->sq_sig_all ? IB_SIGNAL_ALL_WR :
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1427  					      IB_SIGNAL_REQ_WR;
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1428  	attr.qp_type       = cmd->qp_type;
bc38a6abdd5a50 Roland Dreier      2005-07-07  1429  
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1430  	attr.cap.max_send_wr     = cmd->max_send_wr;
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1431  	attr.cap.max_recv_wr     = cmd->max_recv_wr;
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1432  	attr.cap.max_send_sge    = cmd->max_send_sge;
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1433  	attr.cap.max_recv_sge    = cmd->max_recv_sge;
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1434  	attr.cap.max_inline_data = cmd->max_inline_data;
bc38a6abdd5a50 Roland Dreier      2005-07-07  1435  
9ead190bfde2a4 Roland Dreier      2006-06-17  1436  	INIT_LIST_HEAD(&obj->uevent.event_list);
9ead190bfde2a4 Roland Dreier      2006-06-17  1437  	INIT_LIST_HEAD(&obj->mcast_list);
bc38a6abdd5a50 Roland Dreier      2005-07-07  1438  
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1439  	attr.create_flags = cmd->create_flags;
8a06ce59a4cd03 Leon Romanovsky    2015-12-20  1440  	if (attr.create_flags & ~(IB_QP_CREATE_BLOCK_MULTICAST_LOOPBACK |
8a06ce59a4cd03 Leon Romanovsky    2015-12-20  1441  				IB_QP_CREATE_CROSS_CHANNEL |
8a06ce59a4cd03 Leon Romanovsky    2015-12-20  1442  				IB_QP_CREATE_MANAGED_SEND |
b531b909481933 Majd Dibbiny       2016-04-17  1443  				IB_QP_CREATE_MANAGED_RECV |
9e1b161f3b8f14 Noa Osherovich     2017-01-18  1444  				IB_QP_CREATE_SCATTER_FCS |
2dee0e545894c2 Yishai Hadas       2017-06-08  1445  				IB_QP_CREATE_CVLAN_STRIPPING |
e1d2e887336950 Noa Osherovich     2017-10-29  1446  				IB_QP_CREATE_SOURCE_QPN |
e1d2e887336950 Noa Osherovich     2017-10-29  1447  				IB_QP_CREATE_PCI_WRITE_END_PADDING)) {
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1448  		ret = -EINVAL;
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1449  		goto err_put;
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1450  	}
6d8a74972b7115 Eran Ben Elisha    2015-10-21  1451  
2dee0e545894c2 Yishai Hadas       2017-06-08  1452  	if (attr.create_flags & IB_QP_CREATE_SOURCE_QPN) {
0498c2d9984ed2 Parav Pandit       2025-06-26  1453  		if (!rdma_uattrs_has_raw_cap(attrs)) {
2dee0e545894c2 Yishai Hadas       2017-06-08  1454  			ret = -EPERM;
2dee0e545894c2 Yishai Hadas       2017-06-08  1455  			goto err_put;
2dee0e545894c2 Yishai Hadas       2017-06-08  1456  		}
2dee0e545894c2 Yishai Hadas       2017-06-08  1457  
2dee0e545894c2 Yishai Hadas       2017-06-08  1458  		attr.source_qpn = cmd->source_qpn;
2dee0e545894c2 Yishai Hadas       2017-06-08  1459  	}
2dee0e545894c2 Yishai Hadas       2017-06-08  1460  
d2b10794fc1312 Leon Romanovsky    2021-08-03  1461  	qp = ib_create_qp_user(device, pd, &attr, &attrs->driver_udata, obj,
d2b10794fc1312 Leon Romanovsky    2021-08-03  1462  			       KBUILD_MODNAME);
bc38a6abdd5a50 Roland Dreier      2005-07-07  1463  	if (IS_ERR(qp)) {
bc38a6abdd5a50 Roland Dreier      2005-07-07  1464  		ret = PTR_ERR(qp);
fd3c7904db6e05 Matan Barak        2017-04-04  1465  		goto err_put;
bc38a6abdd5a50 Roland Dreier      2005-07-07  1466  	}
5507f67d08cdd9 Leon Romanovsky    2021-08-03  1467  	ib_qp_usecnt_inc(qp);
bc38a6abdd5a50 Roland Dreier      2005-07-07  1468  
9ead190bfde2a4 Roland Dreier      2006-06-17  1469  	obj->uevent.uobject.object = qp;
98a8890f734894 Yishai Hadas       2020-05-19  1470  	obj->uevent.event_file = READ_ONCE(attrs->ufile->default_async_file);
98a8890f734894 Yishai Hadas       2020-05-19  1471  	if (obj->uevent.event_file)
98a8890f734894 Yishai Hadas       2020-05-19  1472  		uverbs_uobject_get(&obj->uevent.event_file->uobj);
bc38a6abdd5a50 Roland Dreier      2005-07-07  1473  
846be90d810c28 Yishai Hadas       2013-08-01  1474  	if (xrcd) {
846be90d810c28 Yishai Hadas       2013-08-01  1475  		obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object,
846be90d810c28 Yishai Hadas       2013-08-01  1476  					  uobject);
846be90d810c28 Yishai Hadas       2013-08-01  1477  		atomic_inc(&obj->uxrcd->refcnt);
fd3c7904db6e05 Matan Barak        2017-04-04  1478  		uobj_put_read(xrcd_uobj);
846be90d810c28 Yishai Hadas       2013-08-01  1479  	}
846be90d810c28 Yishai Hadas       2013-08-01  1480  
b93f3c18727634 Sean Hefty         2011-05-27  1481  	if (pd)
fd3c7904db6e05 Matan Barak        2017-04-04  1482  		uobj_put_obj_read(pd);
b93f3c18727634 Sean Hefty         2011-05-27  1483  	if (scq)
5bd48c18c8cea0 Jason Gunthorpe    2020-01-08  1484  		rdma_lookup_put_uobject(&scq->uobject->uevent.uobject,
5bd48c18c8cea0 Jason Gunthorpe    2020-01-08  1485  					UVERBS_LOOKUP_READ);
9977f4f64bfeb5 Sean Hefty         2011-05-26  1486  	if (rcq && rcq != scq)
5bd48c18c8cea0 Jason Gunthorpe    2020-01-08  1487  		rdma_lookup_put_uobject(&rcq->uobject->uevent.uobject,
5bd48c18c8cea0 Jason Gunthorpe    2020-01-08  1488  					UVERBS_LOOKUP_READ);
9ead190bfde2a4 Roland Dreier      2006-06-17  1489  	if (srq)
9fbe334c6a67c3 Jason Gunthorpe    2020-01-08  1490  		rdma_lookup_put_uobject(&srq->uobject->uevent.uobject,
9fbe334c6a67c3 Jason Gunthorpe    2020-01-08  1491  					UVERBS_LOOKUP_READ);
c70285f880e88c Yishai Hadas       2016-05-23  1492  	if (ind_tbl)
fd3c7904db6e05 Matan Barak        2017-04-04  1493  		uobj_put_obj_read(ind_tbl);
16e51f78a9db36 Leon Romanovsky    2020-07-19  1494  	uobj_finalize_uobj_create(&obj->uevent.uobject, attrs);
16e51f78a9db36 Leon Romanovsky    2020-07-19  1495  
16e51f78a9db36 Leon Romanovsky    2020-07-19  1496  	resp.base.qpn             = qp->qp_num;
16e51f78a9db36 Leon Romanovsky    2020-07-19  1497  	resp.base.qp_handle       = obj->uevent.uobject.id;
16e51f78a9db36 Leon Romanovsky    2020-07-19  1498  	resp.base.max_recv_sge    = attr.cap.max_recv_sge;
16e51f78a9db36 Leon Romanovsky    2020-07-19  1499  	resp.base.max_send_sge    = attr.cap.max_send_sge;
16e51f78a9db36 Leon Romanovsky    2020-07-19  1500  	resp.base.max_recv_wr     = attr.cap.max_recv_wr;
16e51f78a9db36 Leon Romanovsky    2020-07-19  1501  	resp.base.max_send_wr     = attr.cap.max_send_wr;
16e51f78a9db36 Leon Romanovsky    2020-07-19  1502  	resp.base.max_inline_data = attr.cap.max_inline_data;
16e51f78a9db36 Leon Romanovsky    2020-07-19  1503  	resp.response_length = uverbs_response_length(attrs, sizeof(resp));
16e51f78a9db36 Leon Romanovsky    2020-07-19  1504  	return uverbs_response(attrs, &resp, sizeof(resp));
9ead190bfde2a4 Roland Dreier      2006-06-17  1505  
9ead190bfde2a4 Roland Dreier      2006-06-17  1506  err_put:
fd3c7904db6e05 Matan Barak        2017-04-04  1507  	if (!IS_ERR(xrcd_uobj))
fd3c7904db6e05 Matan Barak        2017-04-04  1508  		uobj_put_read(xrcd_uobj);
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1509  	if (!IS_ERR_OR_NULL(pd))
fd3c7904db6e05 Matan Barak        2017-04-04  1510  		uobj_put_obj_read(pd);
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1511  	if (!IS_ERR_OR_NULL(scq))
5bd48c18c8cea0 Jason Gunthorpe    2020-01-08  1512  		rdma_lookup_put_uobject(&scq->uobject->uevent.uobject,
5bd48c18c8cea0 Jason Gunthorpe    2020-01-08  1513  					UVERBS_LOOKUP_READ);
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1514  	if (!IS_ERR_OR_NULL(rcq) && rcq != scq)
5bd48c18c8cea0 Jason Gunthorpe    2020-01-08  1515  		rdma_lookup_put_uobject(&rcq->uobject->uevent.uobject,
5bd48c18c8cea0 Jason Gunthorpe    2020-01-08  1516  					UVERBS_LOOKUP_READ);
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1517  	if (!IS_ERR_OR_NULL(srq))
9fbe334c6a67c3 Jason Gunthorpe    2020-01-08  1518  		rdma_lookup_put_uobject(&srq->uobject->uevent.uobject,
9fbe334c6a67c3 Jason Gunthorpe    2020-01-08  1519  					UVERBS_LOOKUP_READ);
81f8f7454ad9e0 Maher Sanalla      2025-02-26  1520  	if (!IS_ERR_OR_NULL(ind_tbl))
fd3c7904db6e05 Matan Barak        2017-04-04  1521  		uobj_put_obj_read(ind_tbl);
9ead190bfde2a4 Roland Dreier      2006-06-17  1522  
a6a3797df2741a Shamir Rabinovitch 2019-03-31  1523  	uobj_alloc_abort(&obj->uevent.uobject, attrs);
bc38a6abdd5a50 Roland Dreier      2005-07-07  1524  	return ret;
bc38a6abdd5a50 Roland Dreier      2005-07-07  1525  }
bc38a6abdd5a50 Roland Dreier      2005-07-07  1526  

:::::: The code at line 1317 was first introduced by commit
:::::: 5807bb32055bb8badc44bf835ebc376415cd0a17 RDMA/core: Align write and ioctl checks of QP types

:::::: TO: Leon Romanovsky <leonro@nvidia.com>
:::::: CC: Jason Gunthorpe <jgg@nvidia.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

