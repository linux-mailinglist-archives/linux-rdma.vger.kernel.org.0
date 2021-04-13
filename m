Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E14035E94A
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Apr 2021 00:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348698AbhDMWxq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 18:53:46 -0400
Received: from mail-bn7nam10on2043.outbound.protection.outlook.com ([40.107.92.43]:50208
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346222AbhDMWxp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 18:53:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wonl0Ny4OwIUwe7KrNUa0sKWNdjiuYrfhkDq/2miAtDId6iXhY0YNUM+6AqA3Kyy29O2FWrofAy+7+T9Av2fxmrSQeW9kkxRUznMpEJHdXoRHO6HVqvZDK6TI+2Zv0R8zl3OeXS6JkQF9kdx7m4PiDN1zWY6gzAafoO7Z0hxoIukQnRd0LwMVPr9MaFkUo6QXuo6W8J8gh8/eU+t596yMR18hcRDXCFTq22mNZ4wGZaexBWAdhaqOL8d/LwDxUmsMIysGjQGxXp3BLeiD3x2v3lAj8kpZhuYOZnlcxneYi9CksYzl0WqNYfPUAciURZQBLOmVLwtBuNUQ/c2aTR9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRFOzNI7NLkoTzV6wLlkBzBM6NvioCAQc8hkVGW43Y4=;
 b=YGus1afsSgSHz04ckXNgxvsbdE5Cy3DgfMsDM76PdjPM4UboNoARZs+7//VrK4MSLdLwfV7/5UbVrzUdj7/bC0IHetRyY3FA/IQgrwD2PEwsNjQ9v3QgEOUBLlds25lhdSQ08sFJm9wKQC005V4wvuX1u43hXQ8BN9AON5M014BYDpCN7JpqOtEvWCHoSl0qEiz+W/cb1yOSZbOIrrAQ5toZVy+IRLlgK2ocYr9H5/hX/F4YdBDvPPkJj1Ytg/xUzpQ5ZG83YQ+LjNRl53qJ+gtOUgfPuMylKyI6n5NIQmTSah4vG+PgHZSgGhJlcBnl5bp1uSnHU6y9cWwFPltBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRFOzNI7NLkoTzV6wLlkBzBM6NvioCAQc8hkVGW43Y4=;
 b=XCoQc7QMcBsk72TcuvACnoyjz5RwiFPRF3tJJyjoVVMfUC2Ecj6R6XevUHNas1hHYYCguSJFs5P4aT3wTNXnMEJ6vzA5LEoTlMcO5lfOry4Batkd8lZyL4VnENlUx+T2HnqHMVh7/awvPO0Wdjo69Fl4sI6i1/OqBmexw+9FDITcSooaSLorIvrK7DdQ3xguW8XKB2PcqlWQmeChZQH6fDxt9Y2nnKhycpWH3x2U16J5DVhP3rl1yaeVq7aJvJ7HFKYZR2gkQBLVl6g+ZYYmaj1DWuEzteYbJBpi1O0LaHzXvaTd/pUH37zRmQ7ilyUpHsC3QfSE2qjZsgpduyE3dA==
Authentication-Results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (10.255.76.76) by
 DM5PR12MB1659.namprd12.prod.outlook.com (10.172.40.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.18; Tue, 13 Apr 2021 22:53:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 22:53:23 +0000
Date:   Tue, 13 Apr 2021 19:53:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>
Cc:     linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        akinobu.mita@gmail.com, corbet@lwn.net
Subject: Re: [PATCH 0/4] Enable Fault Injection for RTRS
Message-ID: <20210413225321.GA1376340@nvidia.com>
References: <20210406115049.196527-1-gi-oh.kim@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406115049.196527-1-gi-oh.kim@ionos.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR1501CA0019.namprd15.prod.outlook.com
 (2603:10b6:207:17::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR1501CA0019.namprd15.prod.outlook.com (2603:10b6:207:17::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Tue, 13 Apr 2021 22:53:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lWRuL-005m43-Qm; Tue, 13 Apr 2021 19:53:21 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5215e2d7-cfd8-4071-c5d5-08d8fecef0fa
X-MS-TrafficTypeDiagnostic: DM5PR12MB1659:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1659664A9260FD043252DA01C24F9@DM5PR12MB1659.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ly2E6uSzjf1QH7uWQAuzLAe5/JtbNRijoTPfjE62rSVAJmTBh9J0D+Uk2Xrv3PlHK9P/ZKfSKaeSnJg2ho+qCw862N6XGN4vOVhRfiJo+9VWTYDz41iVY9UE8+H/xjIg21+F3uoAde/8XhzGQBOyBmOCevsoQm2IBSnV96UH84t6KeXABzd/pJ6SfVmTxMBfVmj4omdZYn3AkAiAnrAdA+EyIgKdUxDer5Bc5qERbo1vsNkZrkAWWceeUYv8V7TlPMVVhihIghooEQaWjoNDhFflwfryth6pv8+impO+eaYKD/DUvEnEyctMVtKlh6ryIDInfU8TIA8nmEQeSZ2KFqTsF4KQHausRHwUoZpNw4Xp79NF8M18x6m0c7aB8h0ACXDjte25tNUU4VNcg3fBgl1wZc3+yjamI8L36MBzev9tLEJhoAkyNiNP3KXgwg1in10E41W5c3Vm0wUSRjMxMMBorimzUVRqyoZO+RfxEbza1bt5OLkal3fNDpVYkPTCpwIQ7nIsVNhk9YFxniF6S4CSKRDrZIfITSNpzkeZntvOZNfgtt8tdkABPZo6BZNyg4BD6bfv9B7efzkOun7F4F+GGAs1QShmin6WslNiyXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(36756003)(66556008)(2616005)(2906002)(6916009)(478600001)(9746002)(316002)(426003)(8936002)(7416002)(9786002)(66476007)(38100700002)(86362001)(8676002)(4326008)(83380400001)(33656002)(186003)(1076003)(66946007)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7MUd6OxccVNM4MikZ+lzsF+3M01mGgEZlbY+iH/gNdeDBWQAhxxcUYyimzqM?=
 =?us-ascii?Q?aK8h5f8CcIhOySLRyBOrgSF69VMh4r3j6p31QKaDsng78ewIZFPxURXuYRCz?=
 =?us-ascii?Q?aItMTMemvrcmsyvrRU6IW/eR+Q+j9iooSP/l4ipeUdeFTmtmiSBFhKE+Ix0L?=
 =?us-ascii?Q?wtJCVObvhIcB3ZoMyUrWAMW8+jZv3hVGjDylHuTgMzkEPVCgDXmm4wTF4DJf?=
 =?us-ascii?Q?o5CWvXBOr6HuU+tNWbUqnxegve2AeUFdU8yzxydynXWLCMzwokAUMvRyvLQH?=
 =?us-ascii?Q?bK/E542hCWbBPvAiNQBiiTlqIConA3JsEQZ2BFYpzpALw+4L0xRGlJ15EmZ1?=
 =?us-ascii?Q?xEFTZdNVCsRw+li/zr8f9ctqNHnykhVJn40nab+tvSKEHf6A+xGd4OMbGl1r?=
 =?us-ascii?Q?hUZA6L4mSnacUODYc66s6yYu/foHeTRVyGk2g+oQIIzU9o2G5qdYwkWQcRJj?=
 =?us-ascii?Q?oKAJ4rktdgJuV1viAUgWYHa9MT2HE9oonUrvA7X+BXMQzRJ0JxKF2df+pIjL?=
 =?us-ascii?Q?rueLKCB1vh765bUHec89SRdRSsLo09cjrPfocpBZZvqCotCieGQwmrQEaz7o?=
 =?us-ascii?Q?TJq14Zn6plzg1skdUssYPPuLeF+jRVoT78bBQ4eO4enid/QpWsMLXxyDSeyL?=
 =?us-ascii?Q?1idcRXCNEXJ7Jgnjs6CSb2ks2Rgw51BKpfsyTI68v5R7VjZly/IWic2VOh3D?=
 =?us-ascii?Q?7IezVO1nX31od6XknZVuGJVoA7Zuz8ocWdY1SVZR9xaHn+ZPIwSCathFGAyE?=
 =?us-ascii?Q?izE//FCk55N7e1ezZJRg3ilQHhOK+g4LePuQN/1nGqecNKuxIfzmcSInfmkU?=
 =?us-ascii?Q?xoHytbfTy2sEVQvgy1XczeoKRbXYFBWyoA1X7i9QevkUs562l2SVVv9alxMo?=
 =?us-ascii?Q?XpP8+hRGyJP1qZAH+0GjtXLvtURD6p48XQO5dpTMHxv+ujdIMVML/CUE50yr?=
 =?us-ascii?Q?PcT8kcafUEswF1lR4I6Jig8vADhJ1v64QuajTQ1U5iW1y1VBVUHmTLeIE54A?=
 =?us-ascii?Q?bEu6n2VstxE79uaj/NOLZ5kugebbu5ACzwlrWVmiqosQzcGKwP8T7a6r+yzi?=
 =?us-ascii?Q?HZ4j00d4vqz/rBhyTGtZXpsDx2b8KMHtpeiH7U51kHRUUO/4ucI2TI/0iju9?=
 =?us-ascii?Q?0OQHTG/qJKBgSZZp1NA5SGxlaw5dTJd1+EEXBagnL3VzKvn8OjT0btyVdRTw?=
 =?us-ascii?Q?fnjvfqnEhIzRa+crsx9xbOhTnFbVwtOKK7HEoRjUPhEb/YGpHYRjo0TcaPHU?=
 =?us-ascii?Q?dEsVGMMZeDz2waodGPKwY1E7Qpm4HvrOkmQVdqoF5icSC8M+jdbcjTUl2Rfq?=
 =?us-ascii?Q?0RSKiR1f22YBQNbSI9uBZ1j6le4k2qSrd/H5/qeJEou9bQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5215e2d7-cfd8-4071-c5d5-08d8fecef0fa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 22:53:23.5168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UpiD7X82D6fepYgJ/oN5biHSq6vQG2kV1w9wa82QA2oGrkLnissZj1GKAUYH6pAR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1659
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 06, 2021 at 01:50:45PM +0200, Gioh Kim wrote:
> My colleagues and I would like to apply the fault injection
> of the Linux to test error handling of RTRS module. RTRS module
> consists of client and server modules that are connected via
> Infiniband network. So it is important for the client to receive
> the error of the server and handle it smoothly.
> 
> When debugfs is enabled, RTRS is able to export interfaces
> to fail RTRS client and server.
> Following fault injection points are enabled:
> - fail a request processing on RTRS client side
> - fail a heart-beat transferation on RTRS server side
> 
> This patch set is just a starting point. We will enable various
> faults and test as many error cases as possible.
> 
> Best regards
> 
> Gioh Kim (4):
>   RDMA/rtrs: Enable the fault-injection
>   RDMA/rtrs-clt: Inject a fault at request processing
>   RDMA/rtrs-srv: Inject a fault at heart-beat sending
>   docs: fault-injection: Add fault-injection manual of RTRS

I'm going to drop this until you can look into ebpf kprobes, it does
seem the more modern way

Jason
