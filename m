Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD65D456FD8
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 14:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhKSNvU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 08:51:20 -0500
Received: from mail-co1nam11on2041.outbound.protection.outlook.com ([40.107.220.41]:22984
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230410AbhKSNvU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Nov 2021 08:51:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtgjSz/xagtJhabW9p3f3yCUn5BIhWGjJkpP9TUtwZs7YvtRZK8LIxHbaj+6SWepxqRAw56qDDsBixjHHv5nW25iqT3sbcjsfjOvM+piJZWs6ZrwrBremkj5V+OvWjSrMy7G3AVz4oZOdCn1tsaoooUR292QglL/xfeNqiM0UCNZr4ZKy5C0ycWwuYXeunKdtZ/049A96YnP4heCRO2lIO/D5NaMdWxMPfEKbV8GC1pmz732skZLFTQaTe82MlTZq2In42w+wuYRJqzI/ZMZ5hAO4SkfeNimcKHO/KVjUI+wv5aFEusSKBNhHi9z4c9SPbaicAHdI+AIGRzVwj8CvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpVMiiQQvdIrSgHYr78zNoas/Mw8bwqItxS7UFa1ZeY=;
 b=PJYB4T4bCmPNct6xa/CyOAP5RtM1tcXiDLsY0ZabetPpGlKK2NRDpmIE6V/KNULjnQsy5LOYrVJg21MA9s5rw8A90Es4wd5dVC+2jxhnbD1wK26sB5e5mBGMpVkI7lUHGknc5pZaU/Yjh3DxbeZoWxdSVTdSZmpalJ8ijg89nLjZuoFIw5fzgl7P+mlqeKffgdbzNH6q2uFjXJDhEHr2YrWPTTx2yupI7FLMoJfvKSwlvrjQ5JUm0i4wUBqTJFtSYY7jDwX6r0BCLEY5OzbCDBcR1QJVbU/Mp108/uPFZuCXQCZTkcwSjG9Fx7FCSFVa+rzTTLde6zaKWoL2yahdDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpVMiiQQvdIrSgHYr78zNoas/Mw8bwqItxS7UFa1ZeY=;
 b=OIdbHvKaRudRxC1p4xS+LWAWCEswJnZeg/uhuHL6QPodPEgfo93Z9JvbayRII0CYhcHvWBQ5nA9FBRrfb103jFN6n/xjzK4Mc+HFeRcudtxi8AVGqMqyUmwmflqEl9+Oqi5qjgvrAFhuyktZztiLMkTRIWr/hqtiEVNpQkc6/fH6PPm4oJuLmSjKYvbu91HA/IpU/hsL3s1Toevr3gd89i7XJByH0P3BolBfdaXuod8z+DQRvgx9NnbkgvBV0U1RdNyeOxo7CpmO+2lfzmxywhOYvtHCxwtZftXY1TLXveZakzwfDqlcsei7PJiPsq0zGXllApbTvBbWWuh5uWKoRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 13:48:17 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 13:48:17 +0000
Date:   Fri, 19 Nov 2021 09:48:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bryan Tan <bryantan@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, Pv-drivers@vmware.com,
        gregkh@linuxfoundation.org, vdasa@vmware.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH RESEND] MAINTAINERS: Update for VMware PVRDMA driver
Message-ID: <20211119134816.GA2921280@nvidia.com>
References: <1637320770-44878-1-git-send-email-bryantan@vmware.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637320770-44878-1-git-send-email-bryantan@vmware.com>
X-ClientProxiedBy: BLAPR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:208:32a::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0116.namprd03.prod.outlook.com (2603:10b6:208:32a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Fri, 19 Nov 2021 13:48:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mo4FU-00CFyC-74; Fri, 19 Nov 2021 09:48:16 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1baba9d1-1c0b-4805-77c0-08d9ab633d5c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5287:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5287B0C2F6298339E5C7786AC29C9@BL1PR12MB5287.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7BdMjfZ3+VK5VBmhoZShsU9nKsbm6gTfJIZYMNzYEV+KDnkawJ4UzV6YfqE2n5MawnNR5+K9QpnrVWIFMWPpJRG67wXxQbND8xou3fhU7gLIQDwv3iURQ6er/pE9j2ZRWueZUPtIB9lHkbnyv06LW7JDoQ3PrkEXgY7TVWBrqbfOkpH0OVh11J9LGJvLDwbNZrLOKKgBvhMUqnQUl6mdiMI5ReXrs1iszqs/TBeTLwN8dZazYzf9T9ZOw8DxqSS3tWdzMmqRQDOBYu4rWElK9UDs0wTyvbnqmXLEKz007taLqmwoydUP0CZ3d8uz993MffVHB5rwi0W6zPF/fvVG09oqlO7MIcYP8/GD9m6kYMD6oHwd7MlbpqVdbIC3Y5mEAeNgqF+nkzK18i/f9HMUZcWxE8g8O4HJcXlPGH2W5jO4ERV706lsC2LuCNV0Cjmf4YZob7xHed/OcVjCxMLlaYxrsgqX/MOd8LjfW5iMoBod/1sbxKmeeg8KxrmIsP21hKY/1I0GE+/jTNk3thTnZbrEiPbKFK8V2BgJbTCMz84WS6ENai/fq9CaGyOSA6Dpg3QW9QonS1b0oE4kSzg+LxCzlmSTRTWkxl3TBr/+88zDL4zNuVjTR6COY6X9PsgVxfw83S2ssYBd2U1ZkaC2jA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(33656002)(6916009)(426003)(83380400001)(66556008)(9746002)(508600001)(66946007)(9786002)(2616005)(38100700002)(66476007)(186003)(316002)(8936002)(4326008)(1076003)(86362001)(4744005)(2906002)(26005)(5660300002)(15650500001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TcDuLrrX1liNUogRxz7/Boue4NbTdGPlGBuK6kcrrGl4JlxLtvg0CHWURuxL?=
 =?us-ascii?Q?ISIZKAG+QMFz225ZhafNPfnA8bkmVtEvMERYrbaQUaIFIea5sv/xTPe4Ypof?=
 =?us-ascii?Q?imWUDlTr2JnY0j1wE4Af0MhY+e+fR3Vt59jWP0RPXxBtvL1V4B1h+qZfUJvt?=
 =?us-ascii?Q?PWtvAYYCwPXRg2rCOud5oEhH4PL2B0xQV1i6IQaXAZahEIEuUptWxN5MFBer?=
 =?us-ascii?Q?uVVlscEBGlIFhlxPa9VoyVX+EgmL/oqbINyn9qgYQayS590nnBxeRQGoo+KY?=
 =?us-ascii?Q?DYbwCmFo5JbHYuV+fVDf1vcOpQ627esENQ/FMujAM0sMAwVgR9CKiOCSTjnY?=
 =?us-ascii?Q?0FjdR4pGy3+LtREBeCvtcCEElYiws61DJRSl4p/QbC67wtKGGes122FL3gyR?=
 =?us-ascii?Q?0mF5NNz8bu0XvrxWnaHr9IlPr6Mf6mhAESGrnd2EJnPKnVwdjdcVuN7yQLtB?=
 =?us-ascii?Q?1Q/wTkZg813XpRRYLPx0GN1QYBgRAbxtdI+5b+xXQIGvbbprD8Zm2JpGygBg?=
 =?us-ascii?Q?u8mQ2Z0YVYCTUWmASu7jhwax9pH4rIZAezR7V6f/dkJi44+sydO9+w9WGzKc?=
 =?us-ascii?Q?twc6d1tLuFAqBBojwkDMB+KXsz3nfkweWLuEjSvp7tVFtsGFFBDCcjDq7Kbg?=
 =?us-ascii?Q?tx5Xv9QUigZ5fA1PXDysVfPSEdveFS3lZNH2wrf6iBlsCGfm5vn6UdRuzXCv?=
 =?us-ascii?Q?thprKODY8r55/084Vdb+HgRR8CWy9uYM58Qsa2QbIXKdORZs4/x32h/LNLED?=
 =?us-ascii?Q?nJ+227tBKgHYzsG3gP5cGjBauUDpGfVKfVztzusSv9++keuOwehHogzps1QF?=
 =?us-ascii?Q?YIDkeEkrhorSV2aVJnkoDxTe7Aikey2emAdscGaMt23oRTSnZdS9vgWWnyb3?=
 =?us-ascii?Q?GtQHDMKOpzjSGqWCGLVDnTkr7888y5LEa3qSJi1KZwUq6a6O16XkcvVjXvpJ?=
 =?us-ascii?Q?fnQpyGvnTa9K6ekLHgXKHbO+o2HvcweGOyRwehdqDLpM7SNTc4t7Q2DiMtN6?=
 =?us-ascii?Q?fLDo0xEB/+aj9NtW8exNHXHkhagbP10lBec7RFmheNie+khFGgmNyaQzZSfy?=
 =?us-ascii?Q?22kiUV2CveMnJuMcZhbjketf+2rPFWz/Q4CKl0B0rSmQ/AkCsVqLbZRutAXU?=
 =?us-ascii?Q?4GjUHQcOtLf/AX7tnPB33xBPVKdnEOmW05WVTaTcXF6g/cE5yahoQxMAQ3Tm?=
 =?us-ascii?Q?2Qv4T5FCEi4jCroBd9uEqgXA32tpx9H9vlfAFV0YqX+VCIDlpso3teO8kSrX?=
 =?us-ascii?Q?3NoO+j5CkfePQSV0dbtKXbsMjeHhHx8WfRc3yxbvr0Oo9ltaz5gLlmhYl3gf?=
 =?us-ascii?Q?pZNtCvbpg9kV92LWdyjEuSQ0FUIiszqLH8DXtn085jmWgLjsQOo2dSER7CeP?=
 =?us-ascii?Q?WkqRUl5NttHT800EGjSHtvsNQKQfUHIESDNkySanyycYPRzPJ/o2SWcACQsK?=
 =?us-ascii?Q?Zqv/H4axBlRBPT/DPJJTQ2ieNQLrmJwdA2meSpzW5fLBE78T7/Pf+bbdDYMT?=
 =?us-ascii?Q?LOmM9kR7i6nLnpyTvoUGZDFR5iQM3wRDYR7kx7iWXgSQSva2DwggQVixNeop?=
 =?us-ascii?Q?/YEC/Rsvu4l4vqemHU0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1baba9d1-1c0b-4805-77c0-08d9ab633d5c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 13:48:17.0920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNLqnsQxxB7odiFPeRWOZPYRFqVKCiaFU+8tGkbGAan1H2FjWhioU4SDhf71eIGM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 19, 2021 at 03:19:30AM -0800, Bryan Tan wrote:
> Update maintainer info for the VMware PVRDMA driver.
> 
> Reviewed-by: Adit Ranadive <aditr@vmware.com>
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Bryan Tan <bryantan@vmware.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
