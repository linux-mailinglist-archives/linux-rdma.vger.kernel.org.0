Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A54F13176F
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jan 2020 19:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgAFSXq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 13:23:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:25651 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgAFSXq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jan 2020 13:23:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 10:23:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="271261803"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jan 2020 10:23:44 -0800
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jan 2020 10:23:44 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX113.amr.corp.intel.com (10.22.240.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jan 2020 10:23:44 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 6 Jan 2020 10:23:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsitikgShVQagOrwqXS+M40YKZwr7jlb8FanpV88qISpmlB4H4DilZhEoQ9xSNM8y+QcKU2a8NhzZjtVZ563o1HoQlRFahT+TQUNli5zP8rYWFDC4VtTYOWFWHg124HQ5MoIb+UCRvci0is96h0nYEsmtxvcVMdt0waKbI+S2ytWkg98gu9/IpymQNYAWM0kgn/11GshXyauPeML2Z3t49CIwLkgMZuLFSo1rUjNcl5y6CacV93W+c5EG/o1/ZZsvPuXBS0wacn14slkLvA8mlbUuC1+77pCFyRCCVaYGSSxV8wxxRUDhWilvYqWS1UY39JiGnjIPEBmFPAcHL63Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KulSNzumtKMEIyusU/NXxaGDGf+qem+CBjXO1V02E/Y=;
 b=gzEPnOrCq2sgUNiL82HDeTW7vPhF/BnPs4ON9/US3NgT5YeLhPLrC/qWXeSPDTrg8pU/YNiSQQj113SEHP2sbBm77dx62sUGSCvvn90CtawoJVwGw5S+/iaxwvir95J0Rsx6XJWvDs6YeS4iIEtnlmBO+8RVYJccn2oHKv18MrhSZKa0qe7TfwyBtxoCL9m2ZigVbdRfg5Aq/n6qK6n7evGrD2PAMQ1nSUHKajINBNgN+QrdBhcXWeLXtBue4Mmn1da1HNyI03kP55Zpz7k/g7JIPoYefMn1Z5H3yCx6ghgAyzRpMOIZ9is5Np5DemCppCUlLWduQbZl1kxd9fwT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KulSNzumtKMEIyusU/NXxaGDGf+qem+CBjXO1V02E/Y=;
 b=WkoCLzpoS/QH+5G16OiNAx0LjOtXz3uQwWG7Dt0/3AHCVfxIygRTKdqnPH5xGp+J8jRxkRzsrK4CdpKO/00mvoHGk5pyvdcpn4jfApl2At41Ugx0XvosWXdYvkk5bb65TSqpKjH1yTEeOgWXt7ktLhTSxo1txW7hvmN1x00hrbs=
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com (10.174.97.23) by
 MWHPR1101MB2238.namprd11.prod.outlook.com (10.174.98.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 18:23:43 +0000
Received: from MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::d551:b775:1efb:2ed4]) by MWHPR1101MB2271.namprd11.prod.outlook.com
 ([fe80::d551:b775:1efb:2ed4%11]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 18:23:43 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@intel.com>
To:     "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "'linux-rdma@vger.kernel.org'" <linux-rdma@vger.kernel.org>
CC:     "bvanassche@acm.org" <bvanassche@acm.org>
Subject: Recent trace observed in target code during iSer testing
Thread-Topic: Recent trace observed in target code during iSer testing
Thread-Index: AdXEvi9yRk7s01oGS3qaCUi6aFPrnA==
Date:   Mon, 6 Jan 2020 18:23:42 +0000
Message-ID: <MWHPR1101MB2271A83D246FAE4710E47BB2863C0@MWHPR1101MB2271.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mike.marciniszyn@intel.com; 
x-originating-ip: [192.55.52.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ae7ce4c-accc-4e8f-4180-08d792d58fa5
x-ms-traffictypediagnostic: MWHPR1101MB2238:
x-microsoft-antispam-prvs: <MWHPR1101MB22381DB27733F06F21F147E0863C0@MWHPR1101MB2238.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(346002)(366004)(396003)(199004)(189003)(478600001)(26005)(71200400001)(86362001)(45080400002)(81156014)(8676002)(81166006)(186003)(2906002)(6506007)(52536014)(5660300002)(7696005)(110136005)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(55016002)(8936002)(9686003)(4326008)(33656002)(316002)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR1101MB2238;H:MWHPR1101MB2271.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ePyprS6g1XHnTUbM9v7WlEv9U3FyWAkXtZFDEZ4OmfUUvHoH55jtR//P4Tyy+Gu3ksgqYwkp//yPG128ATquI7YUlD9u161kyY31Pj+5mnGOVRSk0XQOpCrMCBP7BiWEfOkxihjtCc2XDWjnTeTmYO+nKBz44UAyzKTTUz6QUVXTrmcWrdWHIFAjr9spC2+EcHxqglco7oadjjjrmWDZJGWHfIX7CkZ4FPbfncw41XBgpFPP7tFN49zN/sbHCG643im88dptYjLLhESPVb8mUZxwYDmtlwDh4yVmwsYKhxqBOMXUur8Eze/4djels2s3q+h5/ad+QkRThQKa3eApsKVBL+xtf8o5QxDQ0wSLCeOpLJITCEEi3zy888jeYXT43djNMKleJh+ukneCuME2T4lQ5cLig2A1ZaMriW5R+1b+wFiunh6xa+2nAIvBRgU5bUS93DzIVmJgI6Mju/OojAssHEEyK+443XHBqg0Aov8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae7ce4c-accc-4e8f-4180-08d792d58fa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 18:23:43.0266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nOg5lTRIn7PKz6XLHpk2GIWFINJbN1sGYsMlz2GmrhRJA66rIlRG9t9Qo/OlWozIne2BY8KFLgFjArLBo52o+S/0tm8z404xXE/gM8m+SeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2238
X-OriginatorOrg: intel.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Seeing the following trace in some target testing for IB ulps:

[28630.870878] ------------[ cut here ]------------
[28630.876936] percpu_ref_kill_and_confirm called more than once on target_=
release_sess_cmd_refcnt [target_core_mod]!
[28630.876962] WARNING: CPU: 1 PID: 65172 at lib/percpu-refcount.c:346 perc=
pu_ref_kill_and_confirm+0x7e/0xa0
[28630.900627] Modules linked in: target_core_user uio tcm_fc libfc scsi_tr=
ansport_fc tcm_loop target_core_pscsi target_core_iblock target_core_file t=
cp_diag udp_diag inet_diag rfkill ib_isert iscsi_target_mod dm_mirror dm_re=
gion_hash target_core_mod dm_log dm_mod rpcrdma sunrpc rdma_ucm ib_iser opa=
_vnic rdma_cm ib_umad iw_cm ib_ipoib libiscsi ib_cm scsi_transport_iscsi in=
tel_rapl_msr intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powerclam=
p coretemp hfi1 kvm rdmavt iTCO_wdt irqbypass iTCO_vendor_support crct10dif=
_pclmul ib_uverbs mxm_wmi crc32_pclmul ghash_clmulni_intel ib_core aesni_in=
tel crypto_simd ipmi_si cryptd mei_me glue_helper ipmi_devintf pcspkr joyde=
v i2c_i801 ipmi_msghandler sg mei wmi lpc_ich ioatdma acpi_power_meter acpi=
_pad ip_tables ext4 mbcache jbd2 sr_mod cdrom sd_mod mgag200 drm_kms_helper=
 syscopyarea sysfillrect sysimgblt fb_sys_fops drm_vram_helper drm_ttm_help=
er ttm drm igb ahci crc32c_intel libahci ptp libata pps_core dca i2c_algo_b=
it
[28631.002240] CPU: 1 PID: 65172 Comm: iscsi_ttx Kdump: loaded Not tainted =
5.5.0-rc2+ #1
[28631.011900] Hardware name: Intel Corporation S2600CWR/S2600CW, BIOS SE5C=
610.86B.01.01.0014.121820151719 12/18/2015
[28631.024409] RIP: 0010:percpu_ref_kill_and_confirm+0x7e/0xa0
[28631.031580] Code: 00 80 3d 0b 3b 1b 01 00 75 c4 48 8b 53 10 48 c7 c6 80 =
a8 6a 85 48 c7 c7 e0 5d 93 85 31 c0 c6 05 ee 3a 1b 01 01 e8 72 68 c7 ff <0f=
> 0b 48 8b 53 08 eb 9c f0 48 83 2b 01 74 02 eb b3 48 8b 43 10 48
[28631.054539] RSP: 0018:ffffb590c7f17df0 EFLAGS: 00010086
[28631.061385] RAX: 0000000000000000 RBX: ffff9a83915d9830 RCX: 00000000000=
00000
[28631.070377] RDX: 0000000000000066 RSI: ffffffff8646ec06 RDI: 00000000000=
00046
[28631.079367] RBP: 0000000000000246 R08: ffffffff8646eba0 R09: ffff17c7871=
af6ce
[28631.088355] R10: 000000000000fe94 R11: 0000000000000375 R12: 00000000000=
00000
[28631.097348] R13: ffff9a7bc3f2c100 R14: ffffb590c7f17e38 R15: ffffb590c7f=
17c58
[28631.106344] FS:  0000000000000000(0000) GS:ffff9a7b9f440000(0000) knlGS:=
0000000000000000
[28631.116424] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[28631.123880] CR2: 00007fedd7c63080 CR3: 0000000912e0a001 CR4: 00000000001=
606e0
[28631.132902] Call Trace:
[28631.136683]  iscsit_close_connection+0x275/0x8e0 [iscsi_target_mod]
[28631.144727]  ? __schedule+0x2d2/0x6e0
[28631.149870]  iscsit_take_action_for_connection_exit+0xf4/0x100 [iscsi_ta=
rget_mod]
[28631.159310]  iscsi_target_tx_thread+0x15f/0x1f0 [iscsi_target_mod]
[28631.167306]  ? remove_wait_queue+0x60/0x60
[28631.172953]  kthread+0xf8/0x130
[28631.177544]  ? iscsit_thread_get_cpumask+0xa0/0xa0 [iscsi_target_mod]
[28631.185841]  ? kthread_bind+0x10/0x10
[28631.191041]  ret_from_fork+0x35/0x40
[28631.196122] ---[ end trace 61d20478f457d4ab ]---

It appears that a call has been added to target_sess_cmd_list_set_waiting()=
 in:

e9d3009b936 ("scsi: target: iscsi: Wait for all commands to finish before f=
reeing a session")

Perhaps the kill has already been called?

Mike


