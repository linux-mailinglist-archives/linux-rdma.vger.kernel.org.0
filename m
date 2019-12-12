Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B796F11C63F
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 08:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfLLHPW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 12 Dec 2019 02:15:22 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:55770 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728048AbfLLHPW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 02:15:22 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.190) BY m9a0013g.houston.softwaregrp.com WITH ESMTP
 FOR linux-rdma@vger.kernel.org;
 Thu, 12 Dec 2019 07:14:14 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0067.microfocus.com (2002:f79:be::f79:be) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 12 Dec 2019 07:14:59 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 12 Dec 2019 07:14:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX+1yg57SnvjllBwSX0FaF2RNK7QkrSHiDJ95kP9HqM0Acb8hx+DiVWNqyTARLHT8JMVvTN/o1cYD6i92RAL28lEXFyu9QS6A3mmuUGUh1eZULOp1qF+8ukv/REFPhZ7LYgCwNqI0c0SRScEIZCOlZYMVNfuGtsVUKCj9/iFeUyMMHShvsD/nHVSZQLqrbC1JGuNy7tlmvijiC++IZTn1HMMvllyxuFJrWrVeAsV1OGpCRA9KTrW21OWq3P5QRDdP8bmCeX8PpD0JtHaB411p85iqlXXkjq7KCQa2GG6tiGjIkgTA2MpdkhwyZ6qBkpuf4t0P32xCsiU1lLAiVzt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhhUAUXZSmS7QiWCwQlFdA7jR2rnWECWP3Wp99D99v0=;
 b=CTspu47jJXjImNq5vmwZ8iCJx+k89x+2eDnvDmAXG4EBS7BkTfeSYXaF34klHZsHwblnjLcj+82+Iw889VSKQ+3fWBKB8/klBeOSatW0ArxIb3Bu+MmKQUfUlnRVYhFuUAH0Uhb1G6H8vb2IXMH8mIEjwtKNRTkxgayqURVADvBvWdYMiZoC1wBr+YMTjHT/0Q8fayy4YRmXTnPtJCmFK7YBgjr/KrLQdHhoxD9wNLeNdQ+uv72zXGdC6x/eHjE8GfdP22AgRVNDOuh7CpkaBg6K1OQCg55fQU0VaabuDq2gBl1j7b/tOjy1UkfM7TTt2OHwxd9tfX0xNKNFc/UTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3298.namprd18.prod.outlook.com (10.255.138.224) by
 BY5PR18MB3138.namprd18.prod.outlook.com (10.255.137.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.17; Thu, 12 Dec 2019 07:14:57 +0000
Received: from BY5PR18MB3298.namprd18.prod.outlook.com
 ([fe80::a1de:6942:4244:53fe]) by BY5PR18MB3298.namprd18.prod.outlook.com
 ([fe80::a1de:6942:4244:53fe%4]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 07:14:57 +0000
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.com>
To:     "Mijakovic, Robert" <Robert.Mijakovic@lrz.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: Problem installing rdma-core 25+ due to incorrect file name in
 rdma_man_pages
Thread-Topic: Problem installing rdma-core 25+ due to incorrect file name in
 rdma_man_pages
Thread-Index: AQHVr37F3p1rauN9vEC6zsBA1OSa1w==
Date:   Thu, 12 Dec 2019 07:14:56 +0000
Message-ID: <BY5PR18MB329888306491E78089EF2644BF550@BY5PR18MB3298.namprd18.prod.outlook.com>
References: <1CF347E8-9262-4957-B7BE-0C22DBB30E63@lrz.de>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=NMoreyChaisemartin@suse.com; 
x-originating-ip: [86.200.148.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a68ebd6d-a6f5-4cd3-dfb9-08d77ed2fe48
x-ms-traffictypediagnostic: BY5PR18MB3138:
x-microsoft-antispam-prvs: <BY5PR18MB31386850C0BCD98F3DAB543DBF550@BY5PR18MB3138.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(504964003)(199004)(189003)(316002)(52536014)(110136005)(966005)(5660300002)(8936002)(81156014)(66446008)(8676002)(81166006)(66556008)(64756008)(33656002)(6506007)(66476007)(53546011)(91956017)(76116006)(66946007)(71200400001)(86362001)(186003)(7696005)(2906002)(26005)(478600001)(9686003)(55016002)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3138;H:BY5PR18MB3298.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AdCqf2yVxWNaKMgQzLaf1hLO0v+slHDjX8f/tjn7u0dXdP2wPaEbSAKi47HdfMvJhRbMNPcE9wST6nIpOvrN/Ngvi71qGQEppuKzZYiOBmYz4y9r9sZenaKjWSFW74IAXeNa+qhfNuK+TVWDLqipYYld9+zNb6KPAjCV031czGv3bmbae3zMR29jUMJNt0x2DllqmFryqcqM3s05oQ7iX2H9BUdQwEPBVBKjSQatv95KM88+XUpla6UZ3CHc1A6X/x512eU8d9y8/3tZBn73iNeDEYCCNP2YXZ3CoD1nFIowCSr0zjKMDSQNhMNBCYdD0jYiNu8kzWjN7eVQfHmWfd6Gc3xjCAo5htHCcFE2wPd9SjQXGj280shQog9wqrfdt8aXDcb7OZq3ajMaKstprBeh5N7t+lvO9swt71JvS+EqFAIH0oSm4A+6qrMH5GltvMdGuL5R30U3tRiCvlt2p0uJkFmBOnVQs2KEGQfO4Y6EvXXhhlnpQnS101aquj+gKj66cm8MdGA3IkHldrX8CXzKsm6rbi2eTHm6d0+fujuqE9QPXCLDTjo45cE+BofM
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a68ebd6d-a6f5-4cd3-dfb9-08d77ed2fe48
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 07:14:56.9136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OV/QXsSeWGEj5hs55fRquHK2dNYOYvKMki6O7umeyfb0AO0wujlenUcPQA6M3bMm2XM7wRN+NLj0NT5YvjWkbPntUn5D4Eir9+Bb8Vh2lf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3138
X-OriginatorOrg: suse.com
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

On 12/10/19 6:25 PM, Mijakovic, Robert wrote:
> Hi guys,
> 
> while installing rdma-core newer that 25 on one of our clusters through spack I have experienced an error:
> -- Installing: <home_directory>/rdma-core/25.0-gcc-matncbz/share/man/man8/check_lft_balance.8
> CMake Error at spack-src/infiniband-diags/man/CMakeLists.txt:45 (file):
>   file INSTALL cannot find
>   “<scratch_directory>/rdma-core-25.0-matncbzfxrol36acyyahlx23fgxyafk6/spack-src/buildlib/pandoc-prebuilt/8dd347a2a5edc4ffd18f9205922fa35a3c8777e9".
> Call Stack (most recent call first):
>   cmake_install.cmake:83 (include)
> 
> Makefile:120: recipe for target 'install' failed
> make: *** [install] Error 1
> 
> Linux distribution and version: SLES 12.SP4
> Linux kernel and version: 4.12.14-95.32-default
> InfiniBand hardware and firmware version: Mellanox Technologies MT27600 Family [Connect-IB], 10.16.1200
> Kernel driver in use: mlx5_core
> 
> Configured with:
> 'cmake' '<scratch_directory>/rdma-core-25.0-matncbzfxrol36acyyahlx23fgxyafk6/spack-src' '-G' 'Unix Makefiles' '-DCMAKE_INSTALL_PREFIX:PATH=<home_directory>/rdma-core/25.0-gcc-matncbz' '-DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo' '-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON' '-DCMAKE_INSTALL_RPATH_USE_LINK_PATH:BOOL=FALSE' '-DCMAKE_INSTALL_RPATH:STRING=<home_directory>/rdma-core/25.0-gcc-matncbz/lib;<home_directory>/rdma-core/25.0-gcc-matncbz/lib64;<home_directory>/libnl/3.3.0-gcc-5k5xt7d/lib' '-DCMAKE_PREFIX_PATH:STRING=<home_directory>/libnl/3.3.0-gcc-5k5xt7d;<home_directory>/pandoc/2.7.3-gcc-klngaxi;<home_directory>/cmake/3.15.3-gcc-whfqqyj;<home_directory>/pkgconf/1.6.1-gcc-fn4iyyb' '-DCMAKE_INSTALL_SYSCONFDIR=<home_directory>/rdma-core/25.0-gcc-matncbz/etc' '-DCMAKE_INSTALL_RUNDIR=/var/run'
> 
> Compiled with:
> 'make' '-j24’
> Installed with:
> 'make' '-j24' 'install’
> 
> The file that was suppose to be copied (8dd347a2a5edc4ffd18f9205922fa35a3c8777e9) is not there.
> Based on the content of the input file (dump_fts.8.in.rst) from which 8dd347a2a5edc4ffd18f9205922fa35a3c8777e9 is suppose to be generated it seems that it is stored under different name, i.e., b003d15c599b5ef09af22508eeec09d65fc91a4e.
> I have checked the process of file creation and it seems that files are listed in rdma_man_pages which are then processed by function(rdma_man_pages) which does something wrong once the file is suppose to be copied back to the install location.
> 
> The question is what and how to patch this thing other than commenting out the man pages?
> Thank you in advance for your time.
> 
> Best regards,
> Robert
> 

There was a thread a couple of days ago on the ML discussing that:
https://marc.info/?l=linux-rdma&m=157553355626314&w=2

There's also a SLE12SP4 package available on OBS: https://build.opensuse.org/package/show/science:HPC/rdma-core

As the SUSE maintainer for this, I feel obligated to point out that this is not officially supported by SUSE. It should unofficially work though :)

Nicolas

