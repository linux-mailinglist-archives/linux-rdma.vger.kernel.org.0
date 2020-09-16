Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8199B26C3A2
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 16:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIPN0v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 09:26:51 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1573 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgIPNXv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Sep 2020 09:23:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f61ff2b0000>; Wed, 16 Sep 2020 05:03:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 16 Sep 2020 05:04:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 16 Sep 2020 05:04:43 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 12:04:43 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 16 Sep 2020 12:04:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJGiwuq4pw+jxEteGeJXjBSlnuJxGVWVaLWQbi4gzBKbobWlqZTLRrTs21CI1ClhvCVaVrJUKFmu3lxqNjnuRkhN0F9aGo0rRIqY7UX/h069ci0JMgJ8bqFkPd85ffbLgHeDO9lJ4Nm7k6kr2rj90QdCU5Q6pGliNljrmel73Ul6dnYQfEkErkp9dxsYVG051hYSZIYykCRMegT3jihmhQeY8QEP2JsZShVVd8DDSx5crRYNRdeu+ExHEcx4Rz7Dq6GkDIRScTojB2rTPz1PjNJr3lLZaJMMr+GqqejE/PwdDRd4Z0waddVfj+t4VO2IIZUoAydUI/IKHyySgI732Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lMkMpYuu6GRTn6Dh93i4jH3HdVCHG1xcocwx0WyThs=;
 b=a4aIt3HP6OXRjJx1vn/ezTACgyomvPjZhfrS3RFSdenfOK2zY5n0EVjeLucHTjelY4a/akHFHoXP/960hY8tx87Sk+BSqw3DpQ8CcRQkgaIHYdA56LJ5K52pXFCALbSLnWil1+pfWjjSYQxi3IwTxkDH3R41ezUurrRP6d6dyllR4X/+5og7gbgHfQixkw7FHfqijmu8pquQEzGVqfb/SzPWpMaqtb1mI7SUWojgRLqrH30ttFwJxblGFa+3mHA4fCeWbF2aXCNksvT70hInr8GcRT4Yox2JiWFCKCxGIdYysw4lhXllVqCKuVw1fTWiCiTCOTZYo2TZeMaz50lhMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3212.namprd12.prod.outlook.com (2603:10b6:5:186::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 12:04:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 12:04:42 +0000
Date:   Wed, 16 Sep 2020 09:04:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 4/4] RDMA/uverbs: Expose the new GID query API
 to user space
Message-ID: <20200916120440.GL1573713@nvidia.com>
References: <20200910142204.1309061-1-leon@kernel.org>
 <20200910142204.1309061-5-leon@kernel.org>
 <20200911195918.GT904879@nvidia.com> <20200913091302.GF35718@unreal>
 <20200914155550.GF904879@nvidia.com> <20200915114704.GB486552@unreal>
 <20200915190614.GE1573713@nvidia.com> <20200916103710.GH486552@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200916103710.GH486552@unreal>
X-ClientProxiedBy: CH2PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:610:4e::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR02CA0019.namprd02.prod.outlook.com (2603:10b6:610:4e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Wed, 16 Sep 2020 12:04:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kIWAy-006v1o-80; Wed, 16 Sep 2020 09:04:40 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0aa2c33d-cb3a-4352-62c1-08d85a38b14e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3212:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3212046A7586A8B44E4EFFAEC2210@DM6PR12MB3212.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WkC4kxdymlgB28BzArPGhczmwxNj/a2E0vgU6nc8ktGXps2bLq5FqyZ4gp4JU7bvMH6vu6jDeoqjTMxC8rFR3WZ+R76ePjyZB7riGiZBhCd3zvV/YGf/uEFxLkiWRHIsWpbjuV+ukCfqBHRKltYbmKEgtIi79pI4cbWcTRyWyHCkcRqO92qrHEsCxs8uq/38RHg2LBPfwzcU19geus3jx7j7BbXiAeBsuuoF7krAkAGB/dAqXjeMo/mX+uO5Du0lOD6DlFRCbh0iwgD9D8UaOLD4cprUWWjFrwfy8IU+RDMmJo0zI8IniuVYw+cbkUkc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(4326008)(54906003)(2906002)(1076003)(66946007)(36756003)(2616005)(4744005)(186003)(66556008)(66476007)(316002)(26005)(5660300002)(33656002)(6916009)(426003)(478600001)(8676002)(8936002)(9746002)(9786002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KT0Xu2RtIorZkZ1kfzU+/7/gPCafVPExaGwDCZbs8K7vuPehtDZaFlofzQ8esxtTKd0jM9bfrKD7p3y2sZ6j3qmXtqe/6AEY9crNzCZsr6KJhDsYaOH4i86VlxiAvHpHpe0CT7cQB47J3jrKFLKrPp6GllIW2uwjx2NooBIRZOnRmcFQvKrxxGT+uH+gS2BxFyfq7ZEhnQJ1JXK2TVSRUc2EI5Zi1sNT+pwXtaJeOdc89NgsDlP598kNpISY1h4RU4JOXu1h9oMqt8qhcWaKvWpgN6ahGDdWnya+MBkeQPKXCI+NNzQWUSIUvCvQvVCn7yclTkO+4ZNAOfQcyGnpi2ZWSs5zqJh/Ft29zQJpHCry09kbNyL55SvNcj3LXwER0X4gVq3KIpq7339ffWpqVhFK4AQfC0JK4MQ4NtjmzXlNniIevH/Mea/kzJLzzEV6Co0/7Nez566iwNoJvcTcwmo2dsxJrhMzzVW/2HT3G/VGVFGw2/6XfyNK9yLTkfy+LP4T5OWNYw1DL3HSeawnDDptf6qoEoUJNdafBEcUzMrK7zMKLGFl2nBdwuyYTWjvYSEo1aICTceSnNFLAa6/PhxIfI9WvBk3PrYakVSEKIc4A5BgfbipFC5tiAaXgCAWPQ9+GxYJBQKBQMW1WPbiOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa2c33d-cb3a-4352-62c1-08d85a38b14e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 12:04:41.9024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x44Dda0aaBrBmFSHIsmlhZxuI9wPzm2uNCH2pB3sjUBrdzI1vaMyxaNt3KGytuqw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3212
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600257835; bh=1lMkMpYuu6GRTn6Dh93i4jH3HdVCHG1xcocwx0WyThs=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=CdT7UUdT8tVwwtG27nmMiIw476/omeWdpoT/L7HJk2Jmv9zse66O+fdlqTV3CQGTp
         U+pJ2dCwf2YxYm4U+4PriZmGSvopKLmFOgtLzihUMrpSmQcVkXjdPuWcz8U7M7mPXU
         pA1+hsfTnRGLZd0H3vv5C4nokt3II7uO5mUzWrNAxCGz8lHYDvCJj66/1d/apKOahA
         HDN97jP+lkuLjzZ/bZPromA29qM4CgSGpgGtj/n5Juh0cIvbI0V+8/Evm1QKJyg+vB
         tB2SAUnUljVgnCDYDOmggmRHqDl1YUm2VVbQWDCqZyRA9P7FUawfjYmnNQBiFCeCHI
         H0pkR5SuHCZ8A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 16, 2020 at 01:37:10PM +0300, Leon Romanovsky wrote:
> It depends on how you want to treat errors from rdma_read_gid_attr_ndev_rcu().
> Current check allows us to ensure that any error returned by this call is
> handled.
> 
> Otherwise we will find ourselves with something like this:
> ndev = rdma_read_gid_attr_ndev_rcu(gid_attr);
> if (IS_ERR(ndev)) {
> 	if (rdma_protocol_roce())
> 		goto error;
> 	if (ERR_PTR(ndev) != -ENODEV)
> 	        goto error;
> }

Isn't it just 

if (IS_ERR(ndev)) {
   if (ERR_PTR(ndev) != -ENODEV)
        goto error;
   index = -1;
}

Which seems fine and clear enough

Jason
