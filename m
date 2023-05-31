Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2410C718AC3
	for <lists+linux-rdma@lfdr.de>; Wed, 31 May 2023 22:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjEaUGN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 May 2023 16:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjEaUGM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 31 May 2023 16:06:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B33B2
        for <linux-rdma@vger.kernel.org>; Wed, 31 May 2023 13:06:10 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJkDi1009444;
        Wed, 31 May 2023 20:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Suzm5wShB+DFN+3AxjWhzEH9S2+cOo9siZySSfio+QM=;
 b=zpx9ymwg3Xnzcg2pFDTGf5/d6D/5sz6KERYb/UY9j9Uxo7NS/HNT2RCumt4Ah5+GKyYA
 0ZRMQxVZNEXKJdQeIvguFUwIcErwpaseuTAlUejej4XNqw5z+Md2gL7237JxMxNV+Wn+
 /2OIxNjV0VCrIVHLZKEtsjYupPiCkSkz7i68cTDyLnhelBvc7D2EkDM0tynm13jHJylB
 m9SYvBRryKCB/kgZanRQ/V7jqTKZK0quMtreMS3eJycuUmp1jHcQNZrl/acqJBHELwzs
 2ukZq3j8s/iAJ67Ke1i7IUhdm3BPXGyGBGeCm2v+9Ndj2OTj25Sg6nw7R6ELWkg4BN3j 5w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjkpw7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 20:06:08 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VIvgJS003733;
        Wed, 31 May 2023 20:06:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4ydrx7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 20:06:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgyyqdRKwAsUoXSCw4U+Z0jvOtWQIBcJ2iK+8RPXm8t82lsEAvZB6r6mVLbrTVGfaj5bLjBpyj3QsiYDeVmpIUL1Rkd8M6SnPlnoaj7fkxSOhDwlGb4inxS8DOAKfnyM0xwrXl6wqHXQYrAr7hvuVafWSdfL/szo/MEsf4Bc5whKSigRGSnO3eqEYKUylZMw6VRDlxizSeftP/LI85Zfaiylz67gAOwYwMjdhVngClsaYb/UmzTgkoAIKytEAtPMzxhpe2CgfbpniuYqpkBrkcgQ8wRdRyrP9+1Jq4/pVt6xKFWNpLC/NMMRhSOTKD0MS4sUFzSyyNAgp+qEdMP04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Suzm5wShB+DFN+3AxjWhzEH9S2+cOo9siZySSfio+QM=;
 b=GHEWx7mvQY9nf3fk17EhMQdUKgWsDWkcsnfwX6ziGqifz9qmpFq2NjtH27DeNhbK0YUUda3DajIFNNXlnqFIhvof3+1XraYC0jURY0mCPN5cTgzKdWpy4rnFQz1S4bmINDjukDYzaryEZP4ckTkcQ/Rof06Y1874LurD7/ibQUC6vR5rnfF5Iwv9GeF8/KmPSPp1r6wuv6aagH9rR06BxBPn4b5drfQvfDJji1rWntmNcTdwqzi7xEmkqt7Bz2MVFXRnK/cVBRh/oAWOUjDO+YmdeJkr7HlzCsAH3yXAhaycBxwLQchzqjDFsQfnBrwLT7NGe+GSQl0VJaZh6mxzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Suzm5wShB+DFN+3AxjWhzEH9S2+cOo9siZySSfio+QM=;
 b=mZmnryuwO4Z54sfh94JXVx8Ek+Le9YcI9VmcII9AaJ9bNWjEJFphZ/j5p5Pl2aieiBUHNw7I0+CePUDLbqN5ILAZwiyYzoC9ukmiryjkeAt04nuUOb9LXVPNSzIpNpMW9i8qN3OvEkMoNgEl3a131TEsPj5qoG5p1nDyJDrhW9k=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4897.namprd10.prod.outlook.com (2603:10b6:208:30f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 20:06:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ecbd:fc46:2528:36db%5]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 20:06:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Saeed Mahameed <saeedm@nvidia.com>, Eli Cohen <elic@nvidia.com>
CC:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: mlx5 WARNING during shutdown 
Thread-Topic: mlx5 WARNING during shutdown 
Thread-Index: AQHZk/tU2yEf0V+x3k2wIIMIlubeIA==
Date:   Wed, 31 May 2023 20:06:05 +0000
Message-ID: <19D363C1-86EE-4A0A-A204-38A37AD96EF1@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4897:EE_
x-ms-office365-filtering-correlation-id: 1324c66a-c3df-4858-a7ab-08db62127779
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x981ZhCaTUoRc/2XMuawLUhNLR+Y+GC0kja26vjlb2ll0CG7YzaCtgB1rft8Wet5aHKwTBhj843HhI5rLN1jAPmt1n9VB6BFr/MvNa2mi61KFXGrMeVaX2WL5WrN3m6TCZ3rYZ3FYj3Xzkf6mWfqgvyIYjamhBQxoBF/f+hzudn69R+5G4EtWyzR3QI/DKwguQqFa8LGCUxvPU9aE+m8m8cwipQfQu+uivlHi3R6jDHlW0OPiDVr0H+Rc/JTPq1vlpFYqofAIjs8mF+aNromNbmRrobSQHbnmZgJaQzNanrTcExqJobs4K9WGifkTR8uNzbXKinrGGtvDMlnLfPPVw5sAqazJTa1v5RvhNuvEq/bkMEYpNuidiIHF6Uu2jiwyLkIrX9TGWh/m5DgBkPFlpyBDX6KJbaGNFIlebbd6lQTkfYbEj86+tiXpywOGzu/6bifyaNiCF73EkcIBzxaGcTNhJK084s0vZ3dw+49TiAixmMpGd2fmtTt+Wjuqjv/2Exxh1+gaWrDQbYV0WWTnOX66FLUc227+ec9/c+RBy0hvIEnrPLIyLAyJGox9gXf3ipyPFSXi43GugnH8L2OcAo4FnXnXBInGgckxNm8pX+nax68evnuKqoxe/ZiGiQmhBJeGm7E553hhN6UESeNtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(91956017)(316002)(66946007)(83380400001)(110136005)(2906002)(76116006)(122000001)(6506007)(26005)(38100700002)(6512007)(66556008)(66476007)(64756008)(66446008)(4326008)(38070700005)(86362001)(2616005)(478600001)(5660300002)(71200400001)(186003)(33656002)(4743002)(45080400002)(41300700001)(6486002)(8676002)(8936002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dl1LlBptnYG0ik6riV2pVqJ1CDaHkNb1bWqh9Qktk9YxLtdeALSBL0xn6HmO?=
 =?us-ascii?Q?q8iH7E/WTDw5jGncUnt3ZrUs/WVM8x+beHk7j83MZvSGciE4EX9rZRZgfbKg?=
 =?us-ascii?Q?Try/5kl0M3B2JXw11Hc0ydPvE97vvwQ6Sqb1OaA5QRz9aEDXt/o+9GFwFcRO?=
 =?us-ascii?Q?C28lkMR/P1X1OF9O8ITA4YN9Hx+G3Ak5yCwUWPSkh7s0McdkJ3o111CREURX?=
 =?us-ascii?Q?HOJ3TSNhkclgw0G19g4uzQj+K4UvxW23jwDhomTFyg7WY50qGzpV9kV94SLf?=
 =?us-ascii?Q?j05jqgo1RkeyibRK0BsW7UzIQ6/QwBmDyeMyy14l0RYm9AJtU3Q4HN8OhZe3?=
 =?us-ascii?Q?M0CN5dvIV8CQSGmpiXBUAsjClR+Mfuea/qdO0MqUG6iM8+mKQouqhqdjgP7c?=
 =?us-ascii?Q?TP5VZGru5u1XUmONnRUV9yMr3WlH5G3SDzYFM0McYJMICrtzvFoHQHNWQsJ6?=
 =?us-ascii?Q?h5qqizD5ZPXWETgd9BB3YvQn3rJxJ3e7rU5QYh9jk3PifL6c0vw+IdSRpVOp?=
 =?us-ascii?Q?eul2dDdSGUSwoBGB5BAqkMO0kKEmAmDGMDj4NivIEmPANBYB2n5/+O8dP4Hl?=
 =?us-ascii?Q?+kk7q9tjmApvz1TmeYLdRrx2PLwiYLGoPwh4FKK5M5nHLcXZsd+A6xvcT043?=
 =?us-ascii?Q?TMs9ZxqUiyniUELU0KO9xvGQZydvANJoGZ9prq2son/TQmA8OhndyloHbLvJ?=
 =?us-ascii?Q?lUeK+zOdKnqK6Q3BLCIhr35+vnrVmrRueQDZ2kYGMJ2FutjALlviK0R24nXA?=
 =?us-ascii?Q?jJyDQCUvGFbkCO0XY5skhgtmKyvGXlMtqlAx0KkmNItOdv1WHzc0ujBPx4gU?=
 =?us-ascii?Q?2gbZQ3dh2/yxugpl1/kJU6ZJX7WRBqcFbWgWv6wvrAvOrXb0fTsJE+hrAxXK?=
 =?us-ascii?Q?AKoHqnybzUgjKJgmICMktpwNDJtfq6Ths8Vvr5TReH9zqY4Su/PdbrMvgzrH?=
 =?us-ascii?Q?TrzBeXNxzP3eerMWuW1Btu1DE3b2GhSL3nfZlxNAvSSuVcFWtnnVcQF8uKcK?=
 =?us-ascii?Q?F1nlRkhM0of+u78ZsWb6Wzm8dCSsK7qrAWpi0BN/GFZh0i/uKVLpWtSZc+6O?=
 =?us-ascii?Q?i8j6IyN2nLdNANwiZf4D6t9+K6WCbw1BBfcb5GrjSzrpqoXFzogxszDPd7Fo?=
 =?us-ascii?Q?2gd99ZsLC6nrtXQmBmv561m8+YChN+Eiqdf6HJOrb/GKDZtBmshBJiYe6/x7?=
 =?us-ascii?Q?PtoKxMaYjchuxmfJdcHI3KZHnE/55uGja2iVN9fPG7jkxvv40myH5OuewSV6?=
 =?us-ascii?Q?hgSTowgborf7JJRbFepwP6Kt65vYkGRVqBkjU3dsYKG/xrCpaU8cbjEKuh/E?=
 =?us-ascii?Q?kWEvCWzIb8t7JefO1/IjKIAmZR7McZSPNvzbM81tZUeDqJr7SgtCiaYxhzCf?=
 =?us-ascii?Q?zc9cVczihoodGZquSplCxiTgfzXrtXmuItCUEWYdvn4kDCDHmFnZusR7KJJK?=
 =?us-ascii?Q?vXFRjnejruq8MuS8fImiiheAgf0aAcBor1JoRI9KG0WWRzDxTBNxmHOMC2UQ?=
 =?us-ascii?Q?fyMBk/oxd168LFtIf9i67bmKfTtTHlbbSj0guM1ywsKlWQ0NPJFHAGGizfZ8?=
 =?us-ascii?Q?Npa6iGMjd9QJe2Gly2Fy3b24xMAYZaGjH3eQkDLl4eajL6+TSJMzu2GFfDWP?=
 =?us-ascii?Q?Jg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <90C92E3DE71AED4CB1AB82A59396335E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C4P4bHYTpXuCPBIAjSwvgcfvqtT3fiz27rXaeGr849rNMjigbaUxlHATUGx/pxZ/K+0h1mririxbj0jGBBDWcxDhNMY3NfEw0eBWnHvOdOcpMD79OdF9u6CYmnEPpo6jzzC+v+PQGgtIf+fcX5E6jMGy2z7SHacEUxLA/N5ubap5m0Gb5bCOhaxlPTIBZ0xwOxtaIth09SSBHxrbf8Nl53jQnfpJPa/uTmTUZFa2ETWGDE1HF6AypdMBM+khnWeDzij/MthMaFc3gY98qpUasXPcAMeoBAD3GB1Zv3LIpSosKC0WVzkcNAyz4P3CZrkLxbqJczNEdg/DccN6SddNOXdGgxrTq6ro2bFWFfaWGhdy0uNGMTzocwG1F1jjYEshqT3IdeGlqvkjomNR7yWByOfm9V0AD2pk6dnMoizilRGimgQ7wSmfRhm6Hm5Yw3zQkHA/Rsd8b+AlppNVxCquFBpd3NTm1wbyJUEHHUrgwwuE1njq1ZDqhwQbv2drej9WbldNkpfmb5FTjU1oL/TQQ5VchxLHJwUUcz78bx09NKNYf/N3+Q8X8eoWgbjr9bshmYqGseC+I7wOw1DEnMCdEn/aEE/37b/2LsCMO5kvhGBha+APJrEtI8Ijvk6Mm1iPXQuoScixV75BxlispOn5+cQVQNQD3TD7uxjf7ctp+ACTYhsM8wjAP12/w8+flKEsIF6jU2A28+yVjU4Gd3tFgc6lN3tDQ4Kw9BTH+ldyjuBgKTdQaDU3NdLIBhu7dluATmxclAGisQWiseU/VSs1H2jdHYeYvEb8IPSAbOREjY0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1324c66a-c3df-4858-a7ab-08db62127779
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 20:06:05.6014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1NMmlHYJqv+cOCvsuP6qS3IbD6SDh+IdQJ70aADDZqeJAeaRs3W5+9DilYfDqk0KlsB9e2aebI8QhLXU7RJKtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_14,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310170
X-Proofpoint-ORIG-GUID: v8r7GnQApRTBCmBb-BHoMqqmBVw9uyUF
X-Proofpoint-GUID: v8r7GnQApRTBCmBb-BHoMqqmBVw9uyUF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The below WARNING displays on the system console multiple
times during shutdown. It does not appear to block shutdown
processing.

This is on 6.4-rc4 with the mlx5_irqs_request_vectors() fix
applied.


[  270.146851][    T1] WARNING: CPU: 7 PID: 1 at kernel/irq/manage.c:2034 f=
ree_irq+0x59/0x70
[  270.155022][    T1] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolve=
r nfs rpcrdma rdma_cm iw_cm qrtr rfkill ib_umad ib_ipoib ib_cm joydev mlx5_=
ib kvm_intel ib_uverbs kvm iTCO_wdt intel_pmc_bxt intel_rapl_msr iTCO_vendo=
r_support ib_core intel_rapl_common sb_edac x86_pkg_temp_thermal intel_powe=
rclamp coretemp mei_me irqbypass intel_uncore ipmi_ssif rapl intel_cstate a=
cpi_ipmi i2c_i801 mei i2c_smbus lpc_ich ioatdma ipmi_si wmi ipmi_devintf ip=
mi_msghandler acpi_pad acpi_power_meter nfsd auth_rpcgss nfs_acl lockd grac=
e fuse sunrpc zram xfs ast mlx5_core drm_kms_helper syscopyarea sysfillrect=
 sysimgblt drm_shmem_helper drm igb crct10dif_pclmul crc32c_intel ghash_clm=
ulni_intel crc32_pclmul mlxfw dca i2c_algo_bit scsi_dh_rdac scsi_dh_emc scs=
i_dh_alua dm_multipath
[  270.222180][    T1] CPU: 7 PID: 1 Comm: systemd-shutdow Tainted: G S    =
  W          6.4.0-rc4-00005-gcb97c84405b4 #12 b7995b33d89b756c6301c99963dc=
9aea845bd15c
[  270.236418][    T1] Hardware name: Supermicro SYS-6028R-T/X10DRi, BIOS 1=
.1a 10/16/2015
[  270.244331][    T1] RIP: 0010:free_irq+0x59/0x70
[  270.248951][    T1] Code: fc ff ff 48 89 c7 48 85 c0 74 14 48 8b 58 50 e=
8 0d 92 18 00 48 89 d8 48 8b 5d f8 c9 c3 0f 0b 31 db 48 89 d8 48 8b 5d f8 c=
9 c3 <0f> 0b 48 c7 80 c0 00 00 00 00 00 00 00 eb c2 0f 1f 84 00 00 00 00
[  270.268389][    T1] RSP: 0018:ffffbb4e40187cb8 EFLAGS: 00010282
[  270.274308][    T1] RAX: ffffa0cf0f51ce00 RBX: ffffa0d28c28b720 RCX: 000=
0000000000000
[  270.282133][    T1] RDX: ffffa0cf0f51ce00 RSI: ffffa0cf00402910 RDI: fff=
fa0cf0f51ce00
[  270.289961][    T1] RBP: ffffbb4e40187cc0 R08: ffffffffb4d30d20 R09: 000=
0000000000000
[  270.297786][    T1] R10: 0000000000000000 R11: ffffffffb4d30d28 R12: fff=
fa0d288bdc5c0
[  270.305610][    T1] R13: 00000000000001a1 R14: ffffa0d28306f150 R15: 000=
00000fee1dead
[  270.313438][    T1] FS:  00007fced88b8b40(0000) GS:ffffa0d66fc40000(0000=
) knlGS:0000000000000000
[  270.322216][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  270.328654][    T1] CR2: 00007f30c9707188 CR3: 000000011233c004 CR4: 000=
00000001706e0
[  270.336481][    T1] Call Trace:
[  270.339627][    T1]  <TASK>
[  270.342426][    T1]  ? show_regs+0x61/0x70
[  270.346527][    T1]  ? __warn+0x89/0x150
[  270.350452][    T1]  ? free_irq+0x59/0x70
[  270.354465][    T1]  ? report_bug+0x169/0x1a0
[  270.358825][    T1]  ? handle_bug+0x40/0x70
[  270.363009][    T1]  ? exc_invalid_op+0x18/0x70
[  270.367542][    T1]  ? asm_exc_invalid_op+0x1b/0x20
[  270.372423][    T1]  ? free_irq+0x59/0x70
[  270.376435][    T1]  ? free_irq+0x12/0x70
[  270.380446][    T1]  mlx5_irq_pool_free_irqs+0x42/0x70 [mlx5_core 1c469b=
a939c75ce6134781bc9a07bebee746cfe5]
[  270.390214][    T1]  mlx5_irq_table_free_irqs+0x41/0x50 [mlx5_core 1c469=
ba939c75ce6134781bc9a07bebee746cfe5]
[  270.400069][    T1]  mlx5_core_eq_free_irqs+0x2d/0x40 [mlx5_core 1c469ba=
939c75ce6134781bc9a07bebee746cfe5]
[  270.409748][    T1]  mlx5_try_fast_unload+0x83/0x1d0 [mlx5_core 1c469ba9=
39c75ce6134781bc9a07bebee746cfe5]
[  270.419334][    T1]  shutdown+0x34/0xb0 [mlx5_core 1c469ba939c75ce613478=
1bc9a07bebee746cfe5]
[  270.427793][    T1]  pci_device_shutdown+0x37/0x60
[  270.432584][    T1]  device_shutdown+0x152/0x240
[  270.437204][    T1]  kernel_restart+0x3a/0x90
[  270.441564][    T1]  __do_sys_reboot+0x19b/0x220
[  270.446181][    T1]  ? vfs_writev+0x9f/0x160
[  270.450456][    T1]  ? do_writev+0x62/0x120
[  270.454641][    T1]  __x64_sys_reboot+0x1b/0x20
[  270.459173][    T1]  do_syscall_64+0x34/0x80
[  270.463445][    T1]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  270.469194][    T1] RIP: 0033:0x7fced9324dc7
[  270.473463][    T1] Code: 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 0=
0 00 00 90 f3 0f 1e fa 89 fa be 69 19 12 28 bf ad de e1 fe b8 a9 00 00 00 0=
f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 39 10 0d 00 f7 d8 64 89 02 b8
[  270.492905][    T1] RSP: 002b:00007fff428c7d48 EFLAGS: 00000206 ORIG_RAX=
: 00000000000000a9
[  270.501161][    T1] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000=
07fced9324dc7
[  270.508988][    T1] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 000=
00000fee1dead
[  270.516814][    T1] RBP: 00007fff428c7f70 R08: 0000000000000000 R09: 000=
0000000000069
[  270.524641][    T1] R10: 00007fff428c7300 R11: 0000000000000206 R12: 000=
0000000000000
[  270.532466][    T1] R13: 0000000000000000 R14: 0000000000000000 R15: 000=
07fff428c8088
[  270.540294][    T1]  </TASK>

--
Chuck Lever


