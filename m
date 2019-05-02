Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A65C012152
	for <lists+linux-rdma@lfdr.de>; Thu,  2 May 2019 19:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfEBRzo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 May 2019 13:55:44 -0400
Received: from mail-eopbgr150085.outbound.protection.outlook.com ([40.107.15.85]:65250
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbfEBRzo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 May 2019 13:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVITLYyExnMl9o+NdIGeYKg2RZrYlOpYZRK1lfVQFmA=;
 b=HyiL468xkZJKt5qKbyRoO3Li9HBh4sXv+oc+Vxgb6YPUkoyM7VO5gd03dv/idhJWG6gkyViYkNcTOmw1P5ZsWCkCBbmy8/oUq+433LDh1eT7QhQO+KWrCEsnICzQWvyQS6OgwnTMzptdmE+2b7THWRzcRN1L5dyjNXVIbRkfVok=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4878.eurprd05.prod.outlook.com (20.177.51.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.18; Thu, 2 May 2019 17:55:41 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 17:55:41 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Thread-Topic: [PATCH for-next v6 10/12] RDMA/efa: Add EFA verbs implementation
Thread-Index: AQHVARA/t6YhcNgq2U2bxKGl+U/wYQ==
Date:   Thu, 2 May 2019 17:55:41 +0000
Message-ID: <20190502175537.GA27697@mellanox.com>
References: <1556707704-11192-1-git-send-email-galpress@amazon.com>
 <1556707704-11192-11-git-send-email-galpress@amazon.com>
In-Reply-To: <1556707704-11192-11-git-send-email-galpress@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0039.prod.exchangelabs.com
 (2603:10b6:208:25::16) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [173.228.226.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9c7f5af-2886-40f6-d505-08d6cf2763f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4878;
x-ms-traffictypediagnostic: VI1PR05MB4878:
x-microsoft-antispam-prvs: <VI1PR05MB48786E00184C1821C3E692FECF340@VI1PR05MB4878.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(73956011)(68736007)(3846002)(25786009)(6116002)(64756008)(6246003)(86362001)(14444005)(54906003)(66556008)(6512007)(66946007)(66446008)(33656002)(6486002)(36756003)(7416002)(66476007)(256004)(229853002)(4326008)(53936002)(305945005)(6436002)(8676002)(66066001)(81156014)(478600001)(8936002)(76176011)(52116002)(14454004)(7736002)(102836004)(386003)(1076003)(486006)(71190400001)(476003)(446003)(6506007)(99286004)(81166006)(2616005)(11346002)(186003)(316002)(26005)(71200400001)(5660300002)(6916009)(4744005)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4878;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xo8mykg4axgC61q0XMnXpvWg7xdC6vXqATiqfvyVNoWCd9hOpE0thXWgW0zk3HBmw3nGU22Ogd/l4ilzWEwWPCD0VULiXpclyuYV/yfiVobpS++meOIRiTVygevExNwi2CDKioz4JwWxgHLV95gP/BASoNhk8EuxHUmnqP4ljfhSV0qS8imijKSdVzxF4Y3mrJtT8Fg2gqjbHxyQhW9Hfv1kNa4cvp7VFceDwmfPSXqODBTi9TYcN2DBHCIQA9KtTmscZUuEKjIOV8clWjDVCPQhOzsdlXFDMIMKzDhxRT4iR3y7G+20foowYb3e1wUMp/1tOJbU0Ck0syvLdSPufFvSYTitWMabc0WQS4Mhg2ggag/WYqXvzAXMCgBo8ngs3QmhIQbF/r/KULQlPwqdvdVHmAgwwddD3ZQJtk1FIxc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D67BBE9E5E50D40805404FEEAE0BAA6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c7f5af-2886-40f6-d505-08d6cf2763f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 17:55:41.1157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4878
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 01, 2019 at 01:48:22PM +0300, Gal Pressman wrote:
> +#define EFA_AENQ_ENABLED_GROUPS \
> +	(BIT(EFA_ADMIN_FATAL_ERROR) | BIT(EFA_ADMIN_WARNING) | \
> +	 BIT(EFA_ADMIN_NOTIFICATION) | BIT(EFA_ADMIN_KEEP_ALIVE))
> +
> +struct efa_mmap_entry {
> +	struct list_head list;

This list is never used

Jason
