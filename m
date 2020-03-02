Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D60F175BF1
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 14:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgCBNlg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 08:41:36 -0500
Received: from mail-eopbgr150075.outbound.protection.outlook.com ([40.107.15.75]:56263
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727627AbgCBNlg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Mar 2020 08:41:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1UxNmO3Tgx31PVQu9bAw+PR6otBDFcCPEWRAGQkEXUWEaKW2J466edtaHIKcFLoFJ85FcR2lePCJkK8JitoSQVBC3cvYNfVQhxwY6esFgA+7tFiCiGSrzhMkynX7bjgKoxJziY5eSEvm19qqzDiq+4b/QUkShxiFJihIdpGJuweSznJWFmRD1tedZZvW+aSMwyE0IBJR5DHdi8lUdl0P1e6OUWc8urPBbEzwikdm8n9twSf9eQuUT9ogcH0outVrBHYq4RW8OWjB80qp1MyFyEnI2TLNmv83tSCgRC4VjNnfMT6NWmZNw8HbLifF4wNkuGapAyfGvYSkqT1BnOi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhKdmwio/ZX19sCN93Pqcd6mY1bNPkmhIt2XZDJJEgM=;
 b=KCdECA4dJy4Olg7jxTcX4VM34zVH51/nBtUh4YF7JKo43GcOOSgr3iZG1qtPTKtRICNlHkX8ooqU370WNA9GRX+GD4dznnwfKRv+3wGDdYZypt61G8XmRFiGsPa+F0LmBrLSbvZCRWfXlrWMCksFO5M3vvckmCQI5J3P+Ewgn4BwNTygao8GgAFDQZ/xmAmz5oydcyamERIGwwlbl0pgjBS14LolrX89+VETlgfih83zWzInEoSz2ZSOutl75y7CNwjQTqdys97A3q9Hhjkqohh406Lbhtd394PCjppYTxqJyTk2H0W6uSuq9XXk62GtoY0Vu4vQGHmIhMZLBJl5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PhKdmwio/ZX19sCN93Pqcd6mY1bNPkmhIt2XZDJJEgM=;
 b=boEdAXnrA3QyrAXoNFln6iHuWLUzwbzH+OjZaWZ4HMEZMNT3/3CMSumsG2DhOpCMKQT+134dn4jq7+yU1YN5UqtOxCUidmGBrDi981t+uVlC7qAOWIxrFJEukGlo/l40CT+hOtIaSrJvSw8YyHN8Nwy4acg4HNvZeLbeV0U7F8o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB3472.eurprd05.prod.outlook.com (10.170.237.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.16; Mon, 2 Mar 2020 13:41:31 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 13:41:31 +0000
Date:   Mon, 2 Mar 2020 09:41:27 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>
Subject: OFA conference note
Message-ID: <20200302134127.GY31668@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:208:234::10) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:208:234::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 13:41:31 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1j8lK3-0004cO-HW; Mon, 02 Mar 2020 09:41:27 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f8a88dc-0a76-46f0-3329-08d7beaf6aa2
X-MS-TrafficTypeDiagnostic: VI1PR05MB3472:
X-Microsoft-Antispam-PRVS: <VI1PR05MB3472E6012C0FA8E74286CF00CFE70@VI1PR05MB3472.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(189003)(199004)(66946007)(66556008)(66476007)(2906002)(33656002)(36756003)(9786002)(6916009)(81156014)(9746002)(81166006)(8676002)(8936002)(4326008)(558084003)(316002)(3480700007)(52116002)(86362001)(1076003)(26005)(5660300002)(7116003)(9686003)(186003)(478600001)(66574012)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3472;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L64+uLknURdux/fHkT2WHJxsuSfl/2sdrX2Sq0TwuK4TbDMojFK8zuuwEj9BTH7HudwwYsPUN4UYUrltPCrUm+nmH84a9ZPgfVIIwpIP3DcJWonwzVdXO2GUrFLRiit6P8saQH6mIrumk+11Q9zP9Wxy9txV8LW2GRggQA+FuDRphoji2QdSUBnfh/rAK0mr6qRAjM/cU/wtYa/8c+JrbvrgubYeGn4XnHrMY0SaBP/MBiGfR1S+jJ3qb5WAhBsm9pUBXMaZhcjccvTcvtWRHLegNqd0ujcJ1pQHjBY/ep1fw1+3DyVBq520pkoxXS8eob47ebFjEH0sNBIbNz27L+XJHCfeRgNjiqvxQ+g9x6Mk75JDEF9h5VrkkvQfGSxJizt+FItlriNtffQs5cS9JNMl6tG0K9HA7KNFQmKsO6SgNRzKv/IWCtSVXNyJzvQY4k5XRmz9yUe1N5Qf2FwMAAy3vcAMCOEc2mry/CT6efuMIa+kKZB11L42OHVAgYVk
X-MS-Exchange-AntiSpam-MessageData: H4oPDEbqACGdgFpxiFjWLsF2apQbEqG7nRpq6qQOY4pR1gXROqEX+/PzkMcPC73YuvPXix5ECJIPCWPYQinsyow4nz4Jew52RBEWzfE3KnJYjB245VDL2yc+78BS+2ySJvVGQKYWgyAYGF63kB7OqQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8a88dc-0a76-46f0-3329-08d7beaf6aa2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 13:41:31.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X7utulS/jPabNoSaQGxs31zQjTxhaVxa7PhFWRXtD+Bxf1or/ikH2LXR1OAHKoLfzEfWuuQ+ToL0EV9ZG/nW6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3472
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hello everyone,

This is just a note that, unfortunately, due to evolving situation
with the corona-virus, Mellanox will not be sending anyone to the
upcoming OFA conference this year.

Please everyone who is attending travel safely!

Regards,
Jason
