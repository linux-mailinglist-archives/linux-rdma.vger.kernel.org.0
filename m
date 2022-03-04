Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5E04CD5F1
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 15:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiCDOKe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Mar 2022 09:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiCDOKd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Mar 2022 09:10:33 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AE31BA901
        for <linux-rdma@vger.kernel.org>; Fri,  4 Mar 2022 06:09:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fd0jcw/KVzZoHgwt8Z8j3Stbbf1MtNzo/lYAZINQnUZAWI9Ehap7IcuvobHj532WbF8HcJ65zO2rK13Dc1f4TOxYuDhEmD8J8GZcrTV7tBtWwiKVP5QRVMeB9/N2dEGs5V0IbJaAmJcPSsvHwogkQlyS9NgTDlhytVaH2ap/UH1Ykco2JITXnN+gjqPIkc8SdIYYbXrwihX0Fs1+V+sduqlNxDFM0zwTuoGBZYaq8HwmO8z2Z4z8kYVgkEIuxlqhOXZzjOU8BHQoqihYJal2CIHqfoX3fJlBxME/SgP/mZ0xXEDGEfx4hBI9Le5EWFvziohpq3m6cnHwS24WCv97Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ai6mBmvnd1XNohr9mo+5ZthOm5lliQSPCa7bCq6pTQ=;
 b=ROLln+D/hqEK72/j9S9ZloT9miJlDZP3SSGcRlmOqVA8aXMwkz/cevwlkTZqrUKa7wilqeUvMXksL6SGj0GwIoVrkdKGIPXj7OY+tT5HSJkI6709hlDtLcaCbZnp1pQl026KVL/E3XH7x4DGpabSvszDdWm5TgBkK3sf/7ki7NBGds6hbTkH9BfZ/sfkY/AR59EyLhTrp+k/Et97mth4t+uFzYieDPkHNd3CYyESYEMSgYmZQYwsZfunTobVy+YmJyk4RqyYfSMvITYHAsA+aYSSLVA9ezkh7rHtPvnTXMFwyWHzYtJAtSvDxbFiupnEu2Q/F0CuZRUPo4qAC6oVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ai6mBmvnd1XNohr9mo+5ZthOm5lliQSPCa7bCq6pTQ=;
 b=bjcbUHUliBjT1Vj+218lbz53ULK0wpY9UWMrJKivNdZ6accXjXiKB9KlZKETcGj2/djcyUkQWPRR1DO3i5HDZ2iE0JBcG+xJ7vz383jcxF+wYYx3VtPwc8L3KsH4SRGgzsAllJwWO5LB57IYVfX6zaCRawTKhd5G/TSfNTHE8JM=
Received: from DM5PR1901MB2053.namprd19.prod.outlook.com (2603:10b6:4:a3::18)
 by BY3PR19MB4850.namprd19.prod.outlook.com (2603:10b6:a03:366::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Fri, 4 Mar
 2022 14:09:44 +0000
Received: from DM5PR1901MB2053.namprd19.prod.outlook.com
 ([fe80::40a4:1a59:3430:8b74]) by DM5PR1901MB2053.namprd19.prod.outlook.com
 ([fe80::40a4:1a59:3430:8b74%6]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 14:09:44 +0000
From:   Sylvain Didelot <sdidelot@ddn.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: 
Thread-Index: AQHYL9F/vxXanxAD/E23ONS+uEpIUw==
Date:   Fri, 4 Mar 2022 14:09:44 +0000
Message-ID: <DM5PR1901MB2053FBF8B992B9F435A28009D3059@DM5PR1901MB2053.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 20e01cd8-b3f3-cd82-505d-8c02f7f8853b
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc93e7cc-2357-4359-37ae-08d9fde8a26b
x-ms-traffictypediagnostic: BY3PR19MB4850:EE_
x-microsoft-antispam-prvs: <BY3PR19MB4850658659EA41E15A15B33CD3059@BY3PR19MB4850.namprd19.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8iq3DP7G9wr040CsDi05p7wTLLRER4uK4xfKVqyOc38sqyiAymDySC9NuPe2QaNEXn9/WjHTfQfvVxX+gYQQN4m0WiR92nTPyaxlkYvS/ifT5/GKbJQ6nOuwluswVaXhygjLeDrL9/SqTe1gSbpt8qdpseoIA9pxrZjgDwZ5Fzq1ElI0lYzLgCBy5EU3Vx1sqF2ZAcrODMmjmY4JW4A5+ojzLznDKxQjcHgsCZLE+HHn7xgYGvNSgnYES3KQoe03vKG8pvf7+LQT8p3XQCuMLHoeIXujlWeyJhhUF36Jm8UrS2IuZGMIUqZkT71tnwl4VNvz+PT59kokjFbA3g5lHPGn+UarZXbNccU3nACm0a03AJyNMcDiXloNHnLlhxOfmU73fu8adnkY3ymZGemMM3NxIU6OzdWxCp+S7bqCOt1mzTUZfc4Pb8p3D9VrIMbPXuYqd4PBXtKEbcW4o2Enza9YAB9oyE2GELeAIp2euVa1yHh86ewpvHQo/6FlyrPReZ2c5MB4lbP2s2wQLraWaJuACcuGwtn1Y2NWj3/pATZiEElaWwnPHO08J0IVs7Ibbm3aauYdLA22OUkQ6T6IzpPeiKZUfna30QIW/zQFSWYK+8ZGj2+pNbAoAOIkT4PmifT3z9P/8qVTjHrxJtwVA9KDWCOkjKnovRTD1gYZFl3JRbcydPRry/qnKFYmV6iKIq07Lu8pwEJbVWtuNcZx0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:fr;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2053.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(38100700002)(71200400001)(66946007)(6916009)(66556008)(66446008)(64756008)(66476007)(76116006)(2906002)(19618925003)(86362001)(558084003)(5406001)(91956017)(55016003)(33656002)(8936002)(508600001)(52536014)(122000001)(38070700005)(5660300002)(6506007)(7696005)(4270600006)(9686003)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZuKbtdrcTEdaJRJohNzoHREZx971C2ZmcLi6aO00cs6Pf5K9xf8iVq+HTv?=
 =?iso-8859-1?Q?3Brs6zJrn7ygFiok8Yjb6nHQ46KJsbQbIvvPPYF4nr8cqf3/hoLjPTAyXQ?=
 =?iso-8859-1?Q?gezTe3MhxrDvDnniAHS8UkhXOsKZoLRzCuLwciHI5Wel/YgxHQSUc0UJxo?=
 =?iso-8859-1?Q?G/QWqmT/h6cJsZXfY1AFfgUZZHDMouX8inob2kHJR2mRsN11Vss03amN74?=
 =?iso-8859-1?Q?GNLMVw7wlUDUsVBAUBkJ0akJW64cNwYlYy5RXrFxW+UW0lTuZR/0zNO+p0?=
 =?iso-8859-1?Q?FFv2Yvefx9E6wHNvt7uarRZR2jBzf/WTp+9Jc4pPUIiS5d6B74UIz1Z/ZI?=
 =?iso-8859-1?Q?FPRHS2CxAJlgWwX9LLHhDlplDZ1ZXKSFZAqEalwWT/+rQULfY3tn2pFTIj?=
 =?iso-8859-1?Q?+u6bLVzMLbsJQZ83qJYpkLsluoGSvBrMYdl7jV+nSPJ7bRI1ZsDiGzNi6e?=
 =?iso-8859-1?Q?EdtrIjwQpYM0IjxkX8uQwwp2ZT0j3OGQozubLdLNJvI3+0/0sEZ83syWwT?=
 =?iso-8859-1?Q?eNmqIwMqJWcSMUE9oPKgUlYe3lcCMu9ZAOtFo5oPSfvL5zsfv9wAOtV1+x?=
 =?iso-8859-1?Q?dB8RXp3SPz1FWVeGt1VSo/gwMxeHFTLpeEPpkP/C8ytqRq8tdGwVxY5FrZ?=
 =?iso-8859-1?Q?Uf9mSza7dZvJJKfpfpXfIszX8Cs4wct5ztGdVUzbwKUrM/0G2DNXk8VL7I?=
 =?iso-8859-1?Q?mbpZ5sNMKo4n5MngPlRZHvctymdGUI08CXMeO3d+ZkwJwdh0aMgppjFAu7?=
 =?iso-8859-1?Q?fpUwykvupy47brNPK+N0aU1E0QeTLq7Ga9Wkaas975n2B+kBD7UnNrCJSZ?=
 =?iso-8859-1?Q?eZYG/20XVSWmg/R+/VUBNh7/M71qwqnFSJku3x3/zZ8TPHe6GLL0chzPdl?=
 =?iso-8859-1?Q?rmgnn3QWIXxf3NxccPCjMMS2CYeHXGCuOus7MtZe4XtyqwJ4j0BcUgiyHa?=
 =?iso-8859-1?Q?k8/SfZsRx2h4cjGhnj/LRI+tKd8rCkipDC5Nc85GeiBcsyGHl7uFRlC+0D?=
 =?iso-8859-1?Q?ELtMa/xMNOGd31jxebfo3MY2Rzzw808sSzCRIpnmpPOhynoIwJOwDb+mRt?=
 =?iso-8859-1?Q?4NNuLGpU/LiD9Kl010DCPmrH0dHqxmQqE4crRB3iiZfRUBHQ1FuEaCfolf?=
 =?iso-8859-1?Q?uzfBjguP6KWcKz4T2BrHSAYV9euXe4oM7OyByvJE2sLS2JGnXZYL5sW4J3?=
 =?iso-8859-1?Q?CdNPwUluiTs4disuVYPIdzu3MZj6nPjjvoyk8eD9OTmYsd0CfyWKz0Lti9?=
 =?iso-8859-1?Q?C4FcaIqxcTk1feaORK+zq4CCknAdACqjbb3HQdNdvVyrcv3yQWGmSGigBy?=
 =?iso-8859-1?Q?+wYnf5UEuOBJSDs4x15Tw/HJd7M973ILfeZHkR57lErsLS1ZoytkZQhdIU?=
 =?iso-8859-1?Q?E+uwGzQdnxVd8RDxlBL/WKzD3YEjLlRj4bRjSi12mRibBHiDsuVYFm3W/q?=
 =?iso-8859-1?Q?Xy/lULJJMchAwfPEMJgvxpNabgQjXy+w5NNwOwuRetNAv5z59zARQbKhW1?=
 =?iso-8859-1?Q?680v4Gu/PU6jQ8yLwbvxovPJd5lTcoP0ewF3Atk194Be60mlV1q9oTDl3W?=
 =?iso-8859-1?Q?cLmS8wnE6pudg8uq4AdEWM1z0riGB3IpoVN9ZBeWUK/jkuxriiYAD4AqUP?=
 =?iso-8859-1?Q?n5W+7QThTZt5couM7k5ix+Wvfk9aWSgar0cqpuFEmIfijgRo0ciXoFoQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2053.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc93e7cc-2357-4359-37ae-08d9fde8a26b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 14:09:44.7874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4OBGPF8DYCqar8lsx4vtRY1spdBM7nzXZhhcV+KuFs9q9yM1ndCxdHKuqn4xMMrb0KSq4payxUN1GiWaRqQrRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR19MB4850
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

 subscribe linux-rdma=
