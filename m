Return-Path: <linux-rdma+bounces-18500-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E9OLTY1wGmUEwQAu9opvQ
	(envelope-from <linux-rdma+bounces-18500-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 19:30:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D708B2EA4A4
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 19:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C5C3011C74
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Mar 2026 18:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A4F373BFB;
	Sun, 22 Mar 2026 18:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djVb6wYE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDA1337BA1;
	Sun, 22 Mar 2026 18:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774204199; cv=none; b=Ysrc9EH49FZcfwEOd4MXUsy2ylIlCd0DKnNQVpPSsyA+VqjTnUT2DuZ+Gh3YzrkOfAc1RjdzGpdqCE/aQvpZ9viJvfKckTHAV8Jujg085qypCPpzTLzOH5Emdmv+w6C92UMYw08ASzzEiNdZDdVGM+cfYagS5Wpl6lXPS3hDTa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774204199; c=relaxed/simple;
	bh=OuQmVOnpE1dsr6xfSVl45FzJtfO0C91WTtNOx1YxVIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4w4B7s4taGFTuviQ6+JeJmp99dX24j5nHv6JTS9//T2Ciqvue5plxdLgnhojqhkkllkmfxEzSBwiBZgJwYuMjY02PQ+FfhZ6Ms4Y6nbO7Fm5/FJCb/M9WjQa81La35zXCfWt6SrFDdCuPUVJVXFU1tDAVQSl6JpBtIlc+E7Cpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djVb6wYE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774204199; x=1805740199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OuQmVOnpE1dsr6xfSVl45FzJtfO0C91WTtNOx1YxVIY=;
  b=djVb6wYElakVUOHHQ02/ZeK9/k5uQrw0pr7NUw1B+2H9DsD9PL8ssnzQ
   00iVEvV0x17N814PbrKEkh3t8OKKf+c5RarJ8nG3BLx+qEFdnfAAG3CF5
   9mJvTU19cxVHmTmWwfK58FiM7inJ14JLKh5CjXUZGS7R7KALe9Rzb3XzY
   +hCkI/Xt/k6TegFF3XrE97ibSFeUgnMECMavnhNs31p8+UM82zOt0F/jS
   lH1UZTU6jqnS6fGMgiWXSDM0CFWCKIJLxNz/VOevAuZyeM3yyvn9LcfCt
   G3LVtcezk3NusmIjc9KCmfoxmwU8YxVt3QcERtPj+XLtm+I2OpcNAOdmS
   w==;
X-CSE-ConnectionGUID: enxRgIQURYGJFcaas729qA==
X-CSE-MsgGUID: VUW5j7+xQGOvRWI6ePUEpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="100669202"
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; 
   d="scan'208";a="100669202"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 11:29:58 -0700
X-CSE-ConnectionGUID: amtU25E2TzqR0+BuE3OF2Q==
X-CSE-MsgGUID: x738vETQRFuJItaxjqxGMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; 
   d="scan'208";a="228745444"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa005.jf.intel.com with ESMTP; 22 Mar 2026 11:29:53 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4NYd-000000006QH-0qgx;
	Sun, 22 Mar 2026 18:29:51 +0000
Date: Sun, 22 Mar 2026 19:29:23 +0100
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Doug Ledford <dledford@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Ingo Molnar <mingo@kernel.org>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] RDMA/hfi1, rdmavt: open-code rvt_set_ibdev_name()
Message-ID: <202603221954.LIO9WBor-lkp@intel.com>
References: <20260320151511.3420818-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320151511.3420818-2-arnd@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[lists.linux.dev,arndb.de,gmail.com,google.com,suse.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-18500-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: D708B2EA4A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Arnd,

kernel test robot noticed the following build errors:

[auto build test ERROR on rdma/for-next]
[also build test ERROR on soc/for-next linus/master v7.0-rc4 next-20260320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/RDMA-hfi1-rdmavt-open-code-rvt_set_ibdev_name/20260322-190924
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
patch link:    https://lore.kernel.org/r/20260320151511.3420818-2-arnd%40kernel.org
patch subject: [PATCH 2/3] RDMA/hfi1, rdmavt: open-code rvt_set_ibdev_name()
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260322/202603221954.LIO9WBor-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260322/202603221954.LIO9WBor-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603221954.LIO9WBor-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/uuid.h:11,
                    from include/linux/mod_devicetable.h:14,
                    from include/linux/pci.h:27,
                    from drivers/infiniband/hw/hfi1/init.c:7:
   drivers/infiniband/hw/hfi1/init.c: In function 'hfi1_alloc_devdata':
>> drivers/infiniband/hw/hfi1/init.c:1240:17: error: passing argument 1 of 'sized_strscpy' from incompatible pointer type [-Wincompatible-pointer-types]
    1240 |         strscpy(&ibdev->name, dev_name(&ibdev->dev), IB_DEVICE_NAME_MAX);
         |                 ^~~~~~~~~~~~
         |                 |
         |                 char (*)[64]
   include/linux/string.h:83:23: note: in definition of macro '__strscpy1'
      83 |         sized_strscpy(dst, src, size + __must_be_cstr(dst) + __must_be_cstr(src))
         |                       ^~~
   drivers/infiniband/hw/hfi1/init.c:1240:9: note: in expansion of macro 'strscpy'
    1240 |         strscpy(&ibdev->name, dev_name(&ibdev->dev), IB_DEVICE_NAME_MAX);
         |         ^~~~~~~
   In file included from include/linux/string.h:386:
   include/linux/fortify-string.h:275:57: note: expected 'char *' but argument is of type 'char (*)[64]'
     275 | __FORTIFY_INLINE ssize_t sized_strscpy(char * const POS p, const char * const POS q, size_t size)
         |                                        ~~~~~~~~~~~~~~~~~^


vim +/sized_strscpy +1240 drivers/infiniband/hw/hfi1/init.c

  1195	
  1196	/**
  1197	 * hfi1_alloc_devdata - Allocate our primary per-unit data structure.
  1198	 * @pdev: Valid PCI device
  1199	 * @extra: How many bytes to alloc past the default
  1200	 *
  1201	 * Must be done via verbs allocator, because the verbs cleanup process
  1202	 * both does cleanup and free of the data structure.
  1203	 * "extra" is for chip-specific data.
  1204	 */
  1205	static struct hfi1_devdata *hfi1_alloc_devdata(struct pci_dev *pdev,
  1206						       size_t extra)
  1207	{
  1208		struct hfi1_devdata *dd;
  1209		struct ib_device *ibdev;
  1210		int ret, nports;
  1211	
  1212		/* extra is * number of ports */
  1213		nports = extra / sizeof(struct hfi1_pportdata);
  1214	
  1215		dd = (struct hfi1_devdata *)rvt_alloc_device(sizeof(*dd) + extra,
  1216							     nports);
  1217		if (!dd)
  1218			return ERR_PTR(-ENOMEM);
  1219		dd->num_pports = nports;
  1220		dd->pport = (struct hfi1_pportdata *)(dd + 1);
  1221		dd->pcidev = pdev;
  1222		pci_set_drvdata(pdev, dd);
  1223	
  1224		ret = xa_alloc_irq(&hfi1_dev_table, &dd->unit, dd, xa_limit_32b,
  1225				GFP_KERNEL);
  1226		if (ret < 0) {
  1227			dev_err(&pdev->dev,
  1228				"Could not allocate unit ID: error %d\n", -ret);
  1229			goto bail;
  1230		}
  1231	
  1232		/*
  1233		 * FIXME: rvt and its users want to touch the ibdev before
  1234		 * registration and have things like the name work. We don't have the
  1235		 * infrastructure in the core to support this directly today, hack it
  1236		 * to work by setting the name manually here.
  1237		 */
  1238		ibdev = &dd->verbs_dev.rdi.ibdev;
  1239		dev_set_name(&ibdev->dev, "%s_%d", class_name(), dd->unit);
> 1240		strscpy(&ibdev->name, dev_name(&ibdev->dev), IB_DEVICE_NAME_MAX);
  1241	
  1242		/*
  1243		 * If the BIOS does not have the NUMA node information set, select
  1244		 * NUMA 0 so we get consistent performance.
  1245		 */
  1246		dd->node = pcibus_to_node(pdev->bus);
  1247		if (dd->node == NUMA_NO_NODE) {
  1248			dd_dev_err(dd, "Invalid PCI NUMA node. Performance may be affected\n");
  1249			dd->node = 0;
  1250		}
  1251	
  1252		/*
  1253		 * Initialize all locks for the device. This needs to be as early as
  1254		 * possible so locks are usable.
  1255		 */
  1256		spin_lock_init(&dd->sc_lock);
  1257		spin_lock_init(&dd->sendctrl_lock);
  1258		spin_lock_init(&dd->rcvctrl_lock);
  1259		spin_lock_init(&dd->uctxt_lock);
  1260		spin_lock_init(&dd->hfi1_diag_trans_lock);
  1261		spin_lock_init(&dd->sc_init_lock);
  1262		spin_lock_init(&dd->dc8051_memlock);
  1263		seqlock_init(&dd->sc2vl_lock);
  1264		spin_lock_init(&dd->sde_map_lock);
  1265		spin_lock_init(&dd->pio_map_lock);
  1266		mutex_init(&dd->dc8051_lock);
  1267		init_waitqueue_head(&dd->event_queue);
  1268		spin_lock_init(&dd->irq_src_lock);
  1269	
  1270		dd->int_counter = alloc_percpu(u64);
  1271		if (!dd->int_counter) {
  1272			ret = -ENOMEM;
  1273			goto bail;
  1274		}
  1275	
  1276		dd->rcv_limit = alloc_percpu(u64);
  1277		if (!dd->rcv_limit) {
  1278			ret = -ENOMEM;
  1279			goto bail;
  1280		}
  1281	
  1282		dd->send_schedule = alloc_percpu(u64);
  1283		if (!dd->send_schedule) {
  1284			ret = -ENOMEM;
  1285			goto bail;
  1286		}
  1287	
  1288		dd->tx_opstats = alloc_percpu(struct hfi1_opcode_stats_perctx);
  1289		if (!dd->tx_opstats) {
  1290			ret = -ENOMEM;
  1291			goto bail;
  1292		}
  1293	
  1294		dd->comp_vect = kzalloc_obj(*dd->comp_vect);
  1295		if (!dd->comp_vect) {
  1296			ret = -ENOMEM;
  1297			goto bail;
  1298		}
  1299	
  1300		/* allocate dummy tail memory for all receive contexts */
  1301		dd->rcvhdrtail_dummy_kvaddr =
  1302			dma_alloc_coherent(&dd->pcidev->dev, sizeof(u64),
  1303					   &dd->rcvhdrtail_dummy_dma, GFP_KERNEL);
  1304		if (!dd->rcvhdrtail_dummy_kvaddr) {
  1305			ret = -ENOMEM;
  1306			goto bail;
  1307		}
  1308	
  1309		atomic_set(&dd->ipoib_rsm_usr_num, 0);
  1310		return dd;
  1311	
  1312	bail:
  1313		hfi1_free_devdata(dd);
  1314		return ERR_PTR(ret);
  1315	}
  1316	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

