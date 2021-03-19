Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD43534271F
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 21:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhCSUrM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 16:47:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:45197 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhCSUq7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 16:46:59 -0400
IronPort-SDR: iwahLnSRNohWkJUcdTckCbqRqUgM8h25V1R5mYHltoVZLpqVGpDAi0WELDPA2Ljp6RBdK3VEo0
 a/kA9DssZCUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="186623408"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="186623408"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 13:46:58 -0700
IronPort-SDR: Ejocqg28TuINMd3ERdZOoxtbCrbsavSG+g+c5eJAGylq72rzQ/ca8YBg0nFB1ea7QYT8SAPxf0
 wtlwg2gZP01w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="413652594"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 19 Mar 2021 13:46:58 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 19 Mar 2021 13:46:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 19 Mar 2021 13:46:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 19 Mar 2021 13:46:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=el8xj3xJSptllV31M/CpYx93wC5ZClDDAkRswRvvyXjqEgkPOgcumcmIoikQXavF7osTF0oZCzPEDyJl2zxCWIilGa7DEWP8lks9xv0cVwxkfe6ndbhVwb4SOzjcLcfqpEdsnktKgPmyybbhmqGLSaXfMVuYtLMjXSzIg4jKVr+V1OwFADA84r/YvOdpZZ/3ZuHJOrfqbBOvk0b/gKpE79nkYP+9o7BgzNTMwqhouPXSvYsoHvcbZLgX2wN0FboVTqjo8IArM1sU9NQMRo0euJ4/7Vwn7m6lzKJLUHQgzC93O3mJllOdtTTzptZOhK3pDt6PyvTTVBksF7uICPpz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89mwHT0kiZFW+wKBfGab5uXbuvuzT1A2LUZCLsixTX8=;
 b=mooaalSB/aaavuAoZwLEnLPT+Ke84QCYOsRvGkUAX9jxYRUpZUa3E4vqrB2vwnzMUH1JSZ+3GzaRmOpznsvOa2MGWLuMvQ0Un3bXmqOGDv6ZdX6om4bmEaHS7QTpcgHEB3WIYIrzA4qs71hSCwC1+gXVJasD3uZH9RQkQAz020llyzbCblQHM9+GCC/W3MvCvMIj5ysNDE35qZl1kSh0gdOvgXjtsylyvXok7by9i0lDiuacLwW9fqVE7Qron2AVxf6dOeEBpIgph8yFKWgUXlDFcpKte3EuaoF62LFQyrPWLu/T0CNVfL9/MiTG+UsLYNrSvI3xjg+wXFX0C70RsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89mwHT0kiZFW+wKBfGab5uXbuvuzT1A2LUZCLsixTX8=;
 b=P0IsaXraRpbi5XIHSV7Gb0+8JrRaLDE85bLJykyi7btTzXgstU7njhX3LCW3XbRjxKoNGMak1JcOxFuY4sYidfDPuOSbLHZIGFxFtmDeiKqA5NjsReiv/E4Zky983n067iYPxpXSHSN7IUwwaOfhnF1IaJbQNZOhsZkvzmMsr4s=
Received: from BL0PR11MB3299.namprd11.prod.outlook.com (2603:10b6:208:6f::10)
 by MN2PR11MB4533.namprd11.prod.outlook.com (2603:10b6:208:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24; Fri, 19 Mar
 2021 20:46:56 +0000
Received: from BL0PR11MB3299.namprd11.prod.outlook.com
 ([fe80::e93c:a632:64d0:a21e]) by BL0PR11MB3299.namprd11.prod.outlook.com
 ([fe80::e93c:a632:64d0:a21e%7]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 20:46:56 +0000
From:   "Rimmer, Todd" <todd.rimmer@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "Wan, Kaike" <kaike.wan@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "Rimmer, Todd" <todd.rimmer@intel.com>
Subject: RE: [PATCH RFC 0/9] A rendezvous module
Thread-Topic: [PATCH RFC 0/9] A rendezvous module
Thread-Index: AQHXHL9NWKHPWRS8q02lI/8GbNsnUaqLVNwAgAAPxoCAABBfgIAAO/qAgAAGJwCAAAPXgIAAB86AgAAC+OA=
Date:   Fri, 19 Mar 2021 20:46:56 +0000
Message-ID: <BL0PR11MB3299C202FCFF25646BFEE9B6F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
References: <20210319125635.34492-1-kaike.wan@intel.com>
 <20210319135302.GS2356281@nvidia.com>
 <SN6PR11MB33115FD9F1F1D6122A9522C0F4689@SN6PR11MB3311.namprd11.prod.outlook.com>
 <20210319154805.GV2356281@nvidia.com>
 <29061edb-b40c-67a9-c329-3c9446f0f434@cornelisnetworks.com>
 <20210319194446.GA2356281@nvidia.com>
 <BL0PR11MB3299928351B241FAAC76E760F6689@BL0PR11MB3299.namprd11.prod.outlook.com>
 <20210319202627.GC2356281@nvidia.com>
In-Reply-To: <20210319202627.GC2356281@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [100.34.146.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e3daa32-2e22-4ab3-1633-08d8eb1822a0
x-ms-traffictypediagnostic: MN2PR11MB4533:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB453359358331A7999FB3DEB7F6689@MN2PR11MB4533.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JP+pEGXS23zN+C7kXg7Md24XNXIss587Keu9ZEHrL08XLvNqeTEH+vEJeKRF2WFwuuUCA0JQFjrmuG+lONqX0Tx/Xgy1maYhZJ2w/VmS18jo5heO4yVidzmyMncdhRAcIuKTSklUVraIYOmXZXU9RG13KRGTnRWbmX2PhfhsrLcP/qGVtlTQyZQ/Se1MHHdKkhp/det6X+CMuLmSUXfVo9F1IGW7J+7Jys/coBJds/UHiyQeYrYlygcD4EtQzITvonT8EAYEzRiCtPKIfKtkYPMIxkwqYZeweoEOm9oKb/hkCg1/GXA3OsO/g70vuOlFiEaXBFZC6IfFN7KZG0EwAZ6zl6UfMp3Hwf1P9ZXtc0iG3uQUBKRcApde6G1c3b/31dKM+Ar9adhsjPUqdbQka0TDorBN+mvnG4rnAbLWz3/zLcpcFN1vw6Bnq5XeFttedzBuGqJH0ZX0U5C4wMs/O06/lxaylX+cQnsT4GyoOUCSHME0BL/hWvLzIH4zpqsNHOy/PzEYAV2ANRWSP8vqbEnqZ5KTO30zyCUKdrB0H79+/RH2nMYJGtdePboKpnIHB8cuLOgYLYXw6g70iBwGV7nk0Wim+GZ7z2utAXmMqvbG/21TiBaVFIRbZfGzMy2bgARmrCe1vf5YnBGR7ciPvMNTmXAzhzdtlbRIZrRKDt8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3299.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(5660300002)(8936002)(33656002)(86362001)(6506007)(316002)(478600001)(186003)(26005)(71200400001)(38100700001)(76116006)(7696005)(66446008)(64756008)(66556008)(66476007)(6916009)(66946007)(4744005)(9686003)(107886003)(2906002)(8676002)(55016002)(54906003)(4326008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MGM606wFxtSsEjKVQ1stJLK20Pe0TTk9ueFN1qF1lKzzGxw8bGd7CLaB9hsf?=
 =?us-ascii?Q?u53eJJwsxWO9nVbjPjERboYc0ZWxv1Hqsurh7J3ROYGQF3HpCkdlE6K3txlX?=
 =?us-ascii?Q?ERt+M7+RV/hIjg+hdnP8H8UvSf0TxJtsf7r0SWUJNf4pYRh4rZFERuNXR69p?=
 =?us-ascii?Q?yw0JOdUbKQykWIiU9827Na9895k9uMMli1kTjAnmMf9iuV5AdUzlFTEEa0u1?=
 =?us-ascii?Q?77Q6Aw+zcnwmjOlG9o7brDWDm8qPRJvQ/uH3FY44APRxQ+/ZekJ4Bp5t98X8?=
 =?us-ascii?Q?AeJOaF582TXoEBFjLZeRkJSVgqnHgmuE5FHe7iO6GF+2IQFXOSYDBkvDL62z?=
 =?us-ascii?Q?fjsayqvXRo8vVbijK8+5iwulvvQ1b/RpSGZjEBvf+jvL8dDbtddP48Wvuimd?=
 =?us-ascii?Q?Z434JxWIa6yVJGkZWXYbisKPnZPzwMsOztkLO+DscaiB9Dth3CEztMZifwST?=
 =?us-ascii?Q?9mUcvK/QPI1cGMcQlIJt6Nr7U2wlROyoInSGe4aqD7S0Yitap3OjMD4Z+lIi?=
 =?us-ascii?Q?RGO9VVh8h3PWSRMOcD4Io7ERhrmetAW42MfKEPJzbIIxGy5X4zVpfkiaC71H?=
 =?us-ascii?Q?+g1ttWoXtOT1RXb/CdvkyFerdtR70zBnGPUiSlwRUE6G/QKepVuPLPtvbZ8d?=
 =?us-ascii?Q?BLxbaZSAD53DuSMitP8if9T++rgXb5gUgdRD2pVXTgV75YIecZat3uhjd4tl?=
 =?us-ascii?Q?3hdML9shhbJXkaDUBS1xWS3f4izGNpFBFUJcalvNq2rvHd21eyxeWfq0TP6q?=
 =?us-ascii?Q?Ac9IYPN1l2LIRBUqb7CQKtyTfgSUicFpFEFCHnMnnh/X9CSMXN9kVmQbdl0+?=
 =?us-ascii?Q?/v2b8vXaIGX3L5N9MYZP5g4CKMqNUraH7YkqGlhGPy3U+7kVHDVO3j5Qu98l?=
 =?us-ascii?Q?f3A6pGjRe1zXolKLvpPvqHkXj8JZXWhiYa2761EhBP472KWhestEq41vOdRi?=
 =?us-ascii?Q?JLhbr5oxZgyqkhjPoOloXA7KKQlD2QCdYKY96rmfkR4WMOkQvmlFCe3UYL4L?=
 =?us-ascii?Q?lfW+7gTTp0h6ShHL04qlWk0xqkc5ivRrc/EnfAR+uc1yI5dAi3JcrbHH0dRM?=
 =?us-ascii?Q?K17ZJ9ctC6AXzIsuB4g1jwXlwWegoZAHaccSZ4gL4K2+RuzSuOyxufzmyKbi?=
 =?us-ascii?Q?fikms57RU2EnGjv20Ng49tauap6Zss/PVkgk6WuhFjsODq8bvZIH+49qzsPH?=
 =?us-ascii?Q?3WE/nLf/36MEoi7788UD4ZdzX0MSOjdYMV1Imt5SKK83k5wh1sbaZoqA1n+A?=
 =?us-ascii?Q?+LwKyQC+fMXVpIu0voOiZdsFledR03gwN5YplvkYMuycaUDKO2fZfqtbkfmT?=
 =?us-ascii?Q?IsmriCi8a8eNkAci6AA7rD2s?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3299.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3daa32-2e22-4ab3-1633-08d8eb1822a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 20:46:56.4425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6vVyaDeYSpwNdwqoYl2hFzigaSJ155xVB6+yEE7uNu90GMERGZHV9+nIJLXnAhPCdP9oNaGZqEqnRM5XN+DeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4533
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> I'm suprirsed to hear someone advocate that is a good thing when we were
> all told that the hfi1 cdev *must* exist because the kernel transition th=
rough
> verbs was far to expensive.
It depends on the goal vendors have with verbs vs other APIs such as libfab=
ric.  hfi1's verbs goal was focused on storage bandwidth and the cdev was f=
ocused on HPC latency and bandwidth for MPI via PSM2 and libfabric.  I'm un=
clear why we are debating hfi1 here, seems it should be in another thread.

> What is a UD-X?
UD-X is a vendor specific set of HW interfaces and wire protocols implement=
ed in UCX for nVidia Connect-X series of network devices.  Many of it's con=
cepts are very similar to those which ipath and hfi1 HW and software implem=
ented.

> rv seems to completely destroy alot of the HPC performance offloads that
> vendors are layering on RC QPs
Different vendors have different approaches to performance and chose differ=
ent design trade-offs.

Todd

