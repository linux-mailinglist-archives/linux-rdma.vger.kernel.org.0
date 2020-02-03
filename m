Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 594B0150EF6
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 18:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgBCRxZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 12:53:25 -0500
Received: from mail-vi1eur05on2088.outbound.protection.outlook.com ([40.107.21.88]:40352
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727311AbgBCRxZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 3 Feb 2020 12:53:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2eaz2dhWlqeH/falyopaMcV0xOMxOCIe6Jp4QnNGkECrRbFe3rzOJi7UiGaDk6qnBtgH7Rkr+e/CzFFSeNACGCYZk5oNwxJquRdo5qsg9BsGep5wFZsxntUf47HtZ/51rwpsdMTIOFfMfHRgqt5fKDr9eCkntYgFoVuYPpcn2P27ra8CAxzMTZY5bXgFCvSemzbEwdw1klsCO3GETOZgXdRw2y/rKw12hfovn8aVwgF1SNbCnMN6t/OIO11Y0zgIJNEVllIi51YxEXkhCIzTXAoj4NurhSDNFeSrOaWBiaRQjMS7zKAxhWtsSWYdCEZ5iU9Z5G+VlEHz1eGms6vKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7icUSulKfC+aZkXpciHhvuiHIXp4h9dpPx7BhBj0x54=;
 b=aaRFLarUUH49RoxbJVEF/k1TUa0xnfqa7Qy7tGp57TlQoOYGOzkrjM0a4/Rf5WMYiFioA1W8HOps/TNtIPIMg56RWcw7dc3ufHBdwzuWAgKmhI6ISSyHdGAEQo3uqI6Il++bdd+Fkm+gdOvRpJVah7QGK9BnR+qpPkMX7OFfR0qBAyACavw+F/uCgavfuNMz2j1EI4TAbJnaXN2xF3uR6PemGF4yvWOpga815uLeEItR8BVBPM/GB2nRDMeI0IrtmnJ5f29ncLOL5uazF5FxlFq8rzVbmH2zhULJbPuFvQjCeaFTHDLpsJDgE68c9JLDppND52vg3ao2ZPWWBKpiRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7icUSulKfC+aZkXpciHhvuiHIXp4h9dpPx7BhBj0x54=;
 b=aKSDXu7xakKJt1dhNbPJ1HmlBO99gX/YlmikpoGPReo7HWU0TCVJPDRfv/EtWKEYio75dWibnEhz7J7iHg5ZzDU3c3fH0tlVGc3kqUaq7vy1h7h8xXef2/xcmuyHOlubi+o1vnW467zV9wwBDONF10rdX01Vl+RvTIb5ob9z3nI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6032.eurprd05.prod.outlook.com (20.178.127.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Mon, 3 Feb 2020 17:53:21 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 17:53:21 +0000
Date:   Mon, 3 Feb 2020 13:53:17 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma@vger.kernel.org, leon@kernel.org
Subject: Re: [PATCH v5] libibverbs: display gid type in ibv_devinfo
Message-ID: <20200203175317.GQ23346@mellanox.com>
References: <1580752324-24742-1-git-send-email-devesh.sharma@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580752324-24742-1-git-send-email-devesh.sharma@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR19CA0032.namprd19.prod.outlook.com
 (2603:10b6:208:178::45) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR19CA0032.namprd19.prod.outlook.com (2603:10b6:208:178::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.33 via Frontend Transport; Mon, 3 Feb 2020 17:53:20 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1iyfuP-0008VH-26; Mon, 03 Feb 2020 13:53:17 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ba00f38-5919-4c94-3dc5-08d7a8d1f4f8
X-MS-TrafficTypeDiagnostic: VI1PR05MB6032:
X-Microsoft-Antispam-PRVS: <VI1PR05MB60328A30F5FD7E168904EBC5CF000@VI1PR05MB6032.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(189003)(199004)(8676002)(81166006)(81156014)(8936002)(6916009)(66946007)(186003)(9746002)(9786002)(4326008)(66476007)(26005)(66556008)(478600001)(52116002)(33656002)(2616005)(4744005)(1076003)(86362001)(36756003)(316002)(5660300002)(2906002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6032;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQaJnDjkb/4MTHFWFeN3QWvl1+MeGk0uAGtAI5Fit1oF1FZ5EGOfxiKp8jM2uSlwUO/9aJzJq3SlwC2XzYBxELP5JEGY7WJ89VZtOX1N7nHT29smt/pF7/LSUgSAGrY43scZLnRFMx+ZpjJsefGSVG9Rj6yC4dOh2ZaMtdBPnCXmTU6zs9a56KrNGsg4FeKm0D4UT6DsA8HCbHA2/6fO2f6LqrFh91QdSRYjZrJu0HjgC6XTwivN2hg6890dbaiXMNS7/WOMfulgauUI9D2IKVAu9hNbb6R2ppMq5aGL3CQmQ+D68wxmkM8jMuTZreYtW5UCKS5H2WKM47M816X6No+dsaFDV72e4AMkd7tLD2O9+Phj5h1A7mt1XIDeLyc8ZTm12Mt4d0hM9vx7GD/JuGVJF0CMtIwrsf83fJ8tjpntur1cbiZrs2WSEpPX/54KAKNBPlOHT/L/5jMyqXimFemM0LmgX54UOQHqwyY05CazSq/EyWWDZBCNle5Grehi
X-MS-Exchange-AntiSpam-MessageData: YaEXY9XRXVznGxsuLdmc7yL5AU+56I7VitZIN/h3TiKHP+R0FhchyqEvbHr9qjUd5uIAB6hsd+eneeICuMWVEXhy19ZKwX+zAXRHuEc3FiBf3F80KqquiOTRDsE+bX32s0ay0NgvzlqzK8xeNtte4A==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba00f38-5919-4c94-3dc5-08d7a8d1f4f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 17:53:20.9654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Whal0IsP3bD4op5/jFBiiLDeC7yypo0N6awMzaeTptF2syw3tkQDH3hrk58t2BlbSxx8mbkWLog/45AqaRfFXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6032
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 03, 2020 at 12:52:04PM -0500, Devesh Sharma wrote:
> It becomes difficult to make out from the output of ibv_devinfo
> if a particular gid index is RoCE v2 or not.
> 
> Adding a string to the output of ibv_devinfo -v to display the
> gid type at the end of gid.
> 
> The output would look something like below:
> $ ibv_devinfo -v -d bnxt_re2
> hca_id: bnxt_re2
>  transport:             InfiniBand (0)
>  fw_ver:                216.0.220.0
>  node_guid:             b226:28ff:fed3:b0f0
>  sys_image_guid:        b226:28ff:fed3:b0f0
>   .
>   .
>   .
>   .
>        phys_state:      LINK_UP (5)
>        GID[  0]:               fe80::b226:28ff:fed3:b0f0, IB/RoCE v1
>        GID[  1]:               fe80::b226:28ff:fed3:b0f0, RoCE v2
>        GID[  2]:               ::ffff:192.170.1.101, IB/RoCE v1
>        GID[  3]:               ::ffff:192.170.1.101, RoCE v2

v1 GIDs are GIDs and should never be formed as IPv6 addreses..

Jason
