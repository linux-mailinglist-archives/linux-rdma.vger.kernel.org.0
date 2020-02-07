Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF4F1155910
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2020 15:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBGONp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Feb 2020 09:13:45 -0500
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:28886
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbgBGONp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Feb 2020 09:13:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jr/OzeIM9QlGmTHr1REk75MFiLAWcP0cJKmhs+5xLpk5efkDLzbA0C0/OcLss6Bk28QrXQHgmT1boNLTAVMzIT1NBFZtOMViBAty8lv6DPJE/bXKF4dvv4yCpfIgwXt/2b34+jIF3NVetWs0sTDfh5hfnDXAI8ZCCiSMTVRW90LOigb/ophgHIDsDBsLT+P33T/4sGbrg0s5mCmPtyRdLhx+YPSAZRTpCJS1wY4iE+wXauZ3i3v7PZHA1T/c5fWv/zoQSLc+/1sZAykD+DHRxwy84qCgCxUqinkrJ1PdZgTNZamaqfDxHn9ujLHTHUsMWfWOthVoaS/vk5ppQ1XxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIUv+PTzbAIBNuXH13b0XAHJ9BvUTdsVNhvrFDfWMO8=;
 b=jkPRcDQmrNgowB2SVBQRwC3liCv7nm7qacZyvX/1yhDH10Bc21xKmmlT9IcLZ5Nuyn2XlNNYgJsbkCeibfQxNsYSjO3WlH5DvJDfhDdw0MudYct66t2/ijugx176E5Na8/ezyQ2YzDgIhBlefrgmzu+rzr8CUo5+1GXwrcLr/TifnYHoPF0C/+Pej0kOENF8j0VWe3crURC2h3mLgnub7CmEU5o55PZNXNl8vxUZMcGASKwalaOeILVtbyKJcMnpzki3FEq2eyIGtdEFjKnyXH15lEYjdxHpvrJb8KdJ8kUySWxosKIp3AUOwoAKWKdr5eJoaP9YN5fNMXiXbLGnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kIUv+PTzbAIBNuXH13b0XAHJ9BvUTdsVNhvrFDfWMO8=;
 b=V2kChZZKqwWAYoWia6YgRpyZAfYMMQK7FJNz6tdLDJZa5px0U7UO8b8pevN+8b+EqxSbG80ApvKhchvclRNgEtSHAxwpPjIUeCYGXoXFvcisPP9Xsw93RuAH5Nrdz4UZwB/NM8UwRs0g+NQfx4Jh/DMi4iZLdfsRppFtI5qnGjc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6640.eurprd05.prod.outlook.com (10.186.160.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Fri, 7 Feb 2020 14:13:42 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::1c00:7925:d5c6:d60d%7]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 14:13:42 +0000
Date:   Fri, 7 Feb 2020 10:13:39 -0400
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     Mark Bloch <markb@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v7] libibverbs: display gid type in ibv_devinfo
Message-ID: <20200207141339.GD4509@mellanox.com>
References: <1580967842-11220-1-git-send-email-devesh.sharma@broadcom.com>
 <88498668-9723-9695-b4e7-3384dde76c36@mellanox.com>
 <CANjDDBgdX1REcRRKKdqaWNR2Y+Om-Kwb0vm_JuP703m0VLe_6g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBgdX1REcRRKKdqaWNR2Y+Om-Kwb0vm_JuP703m0VLe_6g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR0102CA0065.prod.exchangelabs.com
 (2603:10b6:208:25::42) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR0102CA0065.prod.exchangelabs.com (2603:10b6:208:25::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Fri, 7 Feb 2020 14:13:42 +0000
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)    (envelope-from <jgg@mellanox.com>)      id 1j04O3-0001Eu-VS; Fri, 07 Feb 2020 10:13:39 -0400
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3da231cb-745a-4c94-a585-08d7abd7efde
X-MS-TrafficTypeDiagnostic: VI1PR05MB6640:|VI1PR05MB6640:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB66401D468FE72A2B8F0CC918CF1C0@VI1PR05MB6640.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(4326008)(9746002)(86362001)(186003)(52116002)(2906002)(26005)(9786002)(6916009)(33656002)(36756003)(2616005)(8676002)(4744005)(316002)(54906003)(81166006)(81156014)(8936002)(66476007)(66556008)(66946007)(5660300002)(1076003)(478600001)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6640;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xqzOiEQ6cVePWBPGc0oxSeoVkpA3APC4lenK9Q2ButkvDpmBjQvB+pMBEal6+Ewk8NSX+CBGXjsVYinFgbcFGWqIjqaMTFcP7CO1+utRrPbt60Is008VtVG6fyoqgQcVV29eQ1N/bBEILKbEe+bj2IZf72dZ2WhHiDxgtW7S76IjnQVTX374itp7vwawU607kmNH1u41Ht09Z/Kcvr4+azKQdeZuAIauVqeNQdyk2rAKgaoh9L0i3HxyOGQ4fNbfrnQcOlAOuk9SX0kUKYAxqxUgfWY/dXaCzIQVZKHn3SnEM9+sjCrJqvsy9eJ6zCZDtvE1KB/WrrKeNv316+G8o/9t+SEP1skymRU2NQFGb9Jz1zWk7AIv28D9/jwesepLR1+S8yC1yk9+vxBkkH7hicmJ0k4VrSuO7M3gAgeoxaJwGz6rJoRUTq50/ibwWArbL64MGmZrUUJHdarIcDCTvBQIcYnty/bEwF3M2OwnL82il81Ez8h7575PJEAMMeM6
X-MS-Exchange-AntiSpam-MessageData: 14PYFZFdxFmgmOONV+FmqXDo72bpH8kNozjPv74jrRUIpcD+LKbtOeGJVkUAkMkvtYSHKql8Jplp5uP1zHqAGvApvRndvUe7CMaEPazxQiRuOhi1fZQAZZrzetbusBU01uj+11h3kzECs4eCT+ZBNQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da231cb-745a-4c94-a585-08d7abd7efde
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 14:13:42.8507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XA6Wx/6heTWZbqOGlNzQVSxUjqmjLsM5LHO4t2vTn16iTkDd2Mk2Q867t1rOvl0AJvnRJj2X3iVnTUsEzMtHlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6640
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 07, 2020 at 06:07:34PM +0530, Devesh Sharma wrote:
> > > -static int print_all_port_gids(struct ibv_context *ctx, uint8_t port_num, int tbl_len)
> > > +#define DEVINFO_INVALID_GID_TYPE     2
> > > +static const char *gid_type_str(enum ibv_gid_type type)
> > >  {
> > > +     switch (type) {
> > > +     case IBV_GID_TYPE_IB_ROCE_V1: return "IB/RoCE v1";
> >
> > You call this function only if link layer is ethernet, why do you need the "IB/" part?
> Jason do you have any suggestion here, "IB/ROCE v1" is the standard
> string rdma-cm and
> /sys/class/infiniband/bnxt_re0/ports/1/gid_attrs/types/* use to
> distinguish v2 gid from v1/IB gids.

I would ignore the sysfs

If you know for sure it is RoCE v1 then say so

IB doesn't have types so it shouldn't show anything

Jason
