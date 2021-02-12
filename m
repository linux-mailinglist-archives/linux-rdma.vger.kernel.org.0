Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FCD31981C
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 02:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhBLBsF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 20:48:05 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:10284 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229625AbhBLBsC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Feb 2021 20:48:02 -0500
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11C1j1gi016208;
        Fri, 12 Feb 2021 01:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=ZvYryskPuT/52Xw5kbBkqwC7FPC3Or6HL7ZXNSUqPlM=;
 b=L1zQRy57w0wCovTv52Fq1IjLLm5IF1nsnPSmGS9nOX6j9xUQJ+Y6l3Fvec3AeI7FSXkN
 UwHdhUQyoAQ73HGq0fVocWIKX1fHtv4kb3fKVBLy90kUFWc3MNK08ju2I/Z6Ot2bPfEc
 pfAPChJLVPi1dNAT9y/dU9QqzKM7wP1aTAvjii8CP91Yn6BRp76BEBMXbWsHEtuz5Adn
 hQADrcNL3fIZPX2TLxXxN3ES0IP3MNCFzcZE5fhenKVATHccXc8YTXfy1tcdLM5PetB+
 mwhaeSIk1NBZaZ3mcm6bh3HvU9qYCNu6vz0DD79HW5HEPrTLMI7XOF6+dhevMfoYMn59 yA== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 36mavhrbja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Feb 2021 01:47:16 +0000
Received: from G2W6311.americas.hpqcorp.net (g2w6311.austin.hp.com [16.197.64.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id E63A0B1;
        Fri, 12 Feb 2021 01:47:15 +0000 (UTC)
Received: from G9W8677.americas.hpqcorp.net (16.220.49.24) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 12 Feb 2021 01:47:15 +0000
Received: from G2W6311.americas.hpqcorp.net (16.197.64.53) by
 G9W8677.americas.hpqcorp.net (16.220.49.24) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 12 Feb 2021 01:47:15 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.241.52.12) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 12 Feb 2021 01:47:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fO+ApI+Mr8oYV4vir+VxRaIVKjhYC8xkuqQfLPz7qaXW/AeE8NxJCk/w/tjtTvU5pGxvNinNK8XId9NON1AWvjNtO3d5tP8m9K9jEhcTTrZy/ke5Pw6ygcBMvcxxlnE4H9PoDN1H7sBph80Mbky5JwGuvRPAdWI8cTpxn8xaqe8Zu+LfI1YH9E2hfE2qDRVVn5bmIeDhe866OBfDRZiBQGNQaaKxDnfaEqi/6FIa8OVHUY8mwSf1My2oFIZxGSv3BeSntoM3mElDSI77QZBQt30ZyOVGw+hvjEFxMjGhEc1c/u+s8ib5v2jtp+78aYXIune0wAj7wekf1Sel7Aq9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvYryskPuT/52Xw5kbBkqwC7FPC3Or6HL7ZXNSUqPlM=;
 b=bzYCru18fRtAVhSTLrIHkV0vYJwPD/WGQ8KdwMIFFiCOR+Vc+SsPecZcso69tUOuCJTsv3kHwP0gE8kqyX7D3nPDBW5NFj0IAgtwhS5mq3Gn+FLQk24ZJqP5mMWFkRC5YpgvqgWKLnOU6/oTHA9jcRMrqur/v/tAIEdc5Lxa9WRQEfignAsv4xweV9pBbWL/6z4JQZep6F9879EdqT/jhu81pKJrBUID3p2GLX53fPMH8CelOiQci+6/3u89z0XmWm4Wjkjw3jWDmd1y+IYzMIVJuPhq7q7iu1lPOqbScwUX+0BBK27KwuP8GHguwhNbstW9nJyFrCMC6WzPd+j0UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750c::21) by CS1PR8401MB1125.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:750e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Fri, 12 Feb
 2021 01:47:13 +0000
Received: from CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d9c0:54c9:95da:29d8]) by CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::d9c0:54c9:95da:29d8%5]) with mapi id 15.20.3846.030; Fri, 12 Feb 2021
 01:47:13 +0000
From:   "Pearson, Robert B" <robert.pearson2@hpe.com>
To:     kernel test robot <lkp@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>
Subject: RE: [rdma:wip/for-testing] BUILD REGRESSION
 a8ef74e70f50f10d741bb64757dd205318dfd9c7
Thread-Topic: [rdma:wip/for-testing] BUILD REGRESSION
 a8ef74e70f50f10d741bb64757dd205318dfd9c7
Thread-Index: AQHXANR6WJpyHITL8k+WAXP5r+Dq7KpTwENQ
Date:   Fri, 12 Feb 2021 01:47:13 +0000
Message-ID: <CS1PR8401MB0821D79A3F65D7F0634ADBB0BC8B9@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
References: <6025c869.9IC4W01ngzfxHXda%lkp@intel.com>
In-Reply-To: <6025c869.9IC4W01ngzfxHXda%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2603:8081:140c:1a00:a405:36a5:ae73:abc2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6696f63f-174f-4283-33b3-08d8cef81eda
x-ms-traffictypediagnostic: CS1PR8401MB1125:
x-microsoft-antispam-prvs: <CS1PR8401MB1125B9E0D022EF8DF2493A58BC8B9@CS1PR8401MB1125.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FhRtmcST57XOhnKZ02IC/tj5Cfc0ezBuCV9s9VT+DJn0hiuHt4MMKNyP6RhZOxb2VlOGU+ES2AE5niU6/VZVVN6pFUubQnKAu6IJkAECzlge5AJyv+4T0/39T0qmLuZ6bpMkRyBgFwewGj2rFfar96wLomucxurylFHVsKRcYjKH6bXhiXTLOzHlI81YnYTIP9NIilNHRL9RaIgbsEoTUn1qUXdPAo3CZTJrNPiN6KA395ruLNMGehS+M1EID46dl8jEgbXWH9D6+NE3MXxASChRqcNil4r2Ira4kI41VC8jLe+YSKXiduQURL/kpTNCSahj1gLU8yy4C+dS6x3rQKJB5pPXdljLuGGRs8YJIcBlimMysim9Be4Y2g1zWuAARzNvJibTl9PBd50VGP/cEcZ8eDnQGc/Kic3dIG573Ai7lvMhj6P9nQDhZhjhPkLLdfTzFuRx6MTO86mhwapw4NEpdAb3j9Iw2Uy2gmRodpT5Oo8DJ2JDJZUXytNRm6ZGkjHsjHycekoFUYF7yIv9nyb/TGr6QTraToClcHSIHlBXfgaPkLRQVMG1UX7IRUX3qOyTc4qoV7IvjQ5zsHaszF2jJWOxLcpmJvHckEWVOME=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(346002)(366004)(39860400002)(966005)(76116006)(66946007)(33656002)(186003)(7696005)(5660300002)(9686003)(4326008)(478600001)(52536014)(55016002)(316002)(6506007)(66476007)(66556008)(86362001)(64756008)(53546011)(8936002)(83380400001)(8676002)(66446008)(2906002)(71200400001)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Vkrf7pbQT7KXjjoFLOHDqQUlwk0uqvr58vfVWWBR98FA6llX8+8POO2Badzc?=
 =?us-ascii?Q?XqumaxzJfbF3ub71kheUj7klnJLdKYJm5gpJgKhX1otDU9JhnoxZR1suHwR0?=
 =?us-ascii?Q?EphMSCbP3LsdVsH/LXe5cLoLpbppngWhYRQpVP8Pr6O+dIQSuXTU79OeX316?=
 =?us-ascii?Q?cATLzz8siQ+39vO1cNLyis6MFJYiE5R8y9UAUXWwHqK8+sIEY5XpCa0XcROS?=
 =?us-ascii?Q?Uvtyl0GwmQrejw+oLRhEvPPQa1BqWUUcVw4ftzLBucMdiEZ9J70TOf0WdxVl?=
 =?us-ascii?Q?9srCboGVrx3272LL5MTYmD5N3oDcIsxEHkHmSW9Rfbvmo0bsbFS07QLOJcWP?=
 =?us-ascii?Q?6up2yHqDxmLdx9e//EnBFLGZsC4tVwQ287Cj0tWnYlYV6v2lvRqtx9iGKArh?=
 =?us-ascii?Q?8B4e3gbKDsXtYxtxRqDyNw/3ZWZua2GrNi+DWfOyjX1eh1n/zGPzkb2o08gW?=
 =?us-ascii?Q?4eu0rJ+pw/OEkQqeQYDAdycr4fsqj4B72dKT43aH9wnM29rI31wE5Jkt4kmR?=
 =?us-ascii?Q?riHgrCegS5rkWgDCyA3qNsBhHrm/Clicdt6EkSG6ZcY8JJN9NN7Cn1zYzXL/?=
 =?us-ascii?Q?4dbCNxMvVsdVitwV1lRfcb3gVmQKVwRJFFpoepGhs5Uqdnqeo+VVgPm42LWK?=
 =?us-ascii?Q?SBuFWNsLgf0AOhIW6vMD034oveCrh/1ATWJeaInQ+XNWs3P7MeCfHxXXagNP?=
 =?us-ascii?Q?xRHz6+Q30UZh68VOvjdZeKk0g/5rYYZGlNY4aztbuUwmQohmOhyRxpnyIZoy?=
 =?us-ascii?Q?+8gCwBe2XOH7CSOQQHkiFcWdxLleHiiH+PkSDQMItLgKjQbOpfsv/ymjqGJi?=
 =?us-ascii?Q?0EjB4EXmki35ta+cK8wWYN85otL/SBTj0mH3JzBONRUW/jsdWg16Xn8xKmI3?=
 =?us-ascii?Q?VeEEee1HC33PSiT4rkgPI0s9UtvK9NVhPStfiCN98qYjmDnuN1WHQRYYY55S?=
 =?us-ascii?Q?DVCvMUUoBz1I4HsXQwKyXND8FDMKmLNAHTHBggTJaFo+XCK6xjql+AkppEkP?=
 =?us-ascii?Q?abqXqGhP4z1l+mGPw46cfhzZYYfrkqZc2F9Ca+HEuGIYb6krf+GfpBfkXOUZ?=
 =?us-ascii?Q?WiYxQDcFc+ruU5nAUM5JWrHC6YHOOKBKY02y0YGrhVvzJYYQVSPSA8Twakzk?=
 =?us-ascii?Q?+FCdv3yHVYCkwbVqhglt49gWfXpm8+M3f7FiaBlOWt2px8guH6flykfiQJCx?=
 =?us-ascii?Q?ea5BKyMxXidB327TpmiTd1tXLVbU3zyHzyamiDUEgdnCt+IXEa5WXFmVNxi9?=
 =?us-ascii?Q?wS0Diz5/s99smh9ufihOGuCLztnw9Mh0kDnywFB/zrw/OO3qRbwtRVLqTQdH?=
 =?us-ascii?Q?90TMpXQ3rH4/Ar+zy3xrtWtKi9owaIEmd/73zTX2Zsxbz5VOSUFo+kasCEc2?=
 =?us-ascii?Q?29IbQO9/0/teFdUgo8My19j0QC6Y?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6696f63f-174f-4283-33b3-08d8cef81eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 01:47:13.6713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hOEoRpkoPfqv+9dIz5Uu9TG0TnsTByr1kjAk4o58JzXrY0T1Se6iEgIZhZn+bJkwII0TlqSq9dMXPfpRIlPWYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB1125
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-11_07:2021-02-11,2021-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102120009
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sounds like it.

-----Original Message-----
From: kernel test robot <lkp@intel.com>=20
Sent: Thursday, February 11, 2021 6:15 PM
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-rdma@vger.kernel.org; Doug Ledford <dledford@redhat.com>
Subject: [rdma:wip/for-testing] BUILD REGRESSION a8ef74e70f50f10d741bb64757=
dd205318dfd9c7

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git =
wip/for-testing branch HEAD: a8ef74e70f50f10d741bb64757dd205318dfd9c7  Merg=
e branch 'k.o/for-next' into k.o/wip/for-testing

Error/Warning in current branch:

drivers/infiniband/sw/rxe/rxe_net.c:164:26: error: use of undeclared identi=
fier 'rdev'; did you mean 'ndev'?

Error/Warning ids grouped by kconfigs:

clang_recent_errors
|-- x86_64-randconfig-a011-20210209
|   `--=20
|drivers-infiniband-sw-rxe-rxe_net.c:error:use-of-undeclared-identifier-
|rdev
|-- x86_64-randconfig-a014-20210209
|   `--=20
|drivers-infiniband-sw-rxe-rxe_net.c:error:use-of-undeclared-identifier-
|rdev
`-- x86_64-randconfig-a015-20210209
    `-- drivers-infiniband-sw-rxe-rxe_net.c:error:use-of-undeclared-identif=
ier-rdev

elapsed time: 1443m

configs tested: 154
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         shannon_defconfig
sh                          rsk7203_defconfig
sparc                               defconfig
mips                      bmips_stb_defconfig
arm                              alldefconfig
arm                           sama5_defconfig
m68k                        mvme147_defconfig
arm                          badge4_defconfig
sh                        dreamcast_defconfig
riscv                    nommu_virt_defconfig
openrisc                         alldefconfig
arm                         bcm2835_defconfig
powerpc                    klondike_defconfig
mips                          malta_defconfig
powerpc                        cell_defconfig
m68k                       m5249evb_defconfig
powerpc                     sbc8548_defconfig
sh                            shmin_defconfig
arm                          pxa168_defconfig
openrisc                  or1klitex_defconfig
powerpc                      obs600_defconfig
powerpc                mpc7448_hpc2_defconfig
arc                        nsimosci_defconfig
powerpc                      tqm8xx_defconfig
mips                      fuloong2e_defconfig
powerpc                      cm5200_defconfig
powerpc                         wii_defconfig
sh                           se7343_defconfig
powerpc                      mgcoge_defconfig
mips                  maltasmvp_eva_defconfig
x86_64                           alldefconfig
arm                         s5pv210_defconfig
arm                        cerfcube_defconfig
mips                         tb0226_defconfig
powerpc                 mpc834x_itx_defconfig
arm                         socfpga_defconfig
mips                         db1xxx_defconfig
mips                     loongson1c_defconfig
m68k                           sun3_defconfig
xtensa                         virt_defconfig
arm                        magician_defconfig
mips                           ip32_defconfig
powerpc                     tqm8540_defconfig
sh                          kfr2r09_defconfig
nios2                         10m50_defconfig
mips                 decstation_r4k_defconfig
powerpc                  mpc885_ads_defconfig
arc                         haps_hs_defconfig
arm                          prima2_defconfig
powerpc                          g5_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                      chrp32_defconfig
um                           x86_64_defconfig
arm64                            alldefconfig
powerpc                      bamboo_defconfig
arm                  colibri_pxa270_defconfig
sh                             shx3_defconfig
arm                    vt8500_v6_v7_defconfig
arm                        realview_defconfig
mips                         tb0287_defconfig
powerpc                    socrates_defconfig
mips                            ar7_defconfig
powerpc                     tqm8555_defconfig
powerpc                          allmodconfig
powerpc                 xes_mpc85xx_defconfig
m68k                        m5407c3_defconfig
sh                         apsh4a3a_defconfig
powerpc                     ep8248e_defconfig
mips                        omega2p_defconfig
nios2                            alldefconfig
mips                           ip27_defconfig
powerpc                      katmai_defconfig
arm                           tegra_defconfig
xtensa                       common_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
x86_64               randconfig-a016-20210211
x86_64               randconfig-a013-20210211
x86_64               randconfig-a012-20210211
x86_64               randconfig-a015-20210211
x86_64               randconfig-a014-20210211
x86_64               randconfig-a011-20210211
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation https://lists.01.org/hyperk=
itty/list/kbuild-all@lists.01.org
