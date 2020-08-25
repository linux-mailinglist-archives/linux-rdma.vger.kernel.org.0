Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F27E251AD7
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 16:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgHYOcc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 10:32:32 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6768 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHYOca (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 10:32:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4520860000>; Tue, 25 Aug 2020 07:30:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Aug 2020 07:32:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 25 Aug 2020 07:32:29 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 14:32:09 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.50) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 25 Aug 2020 14:32:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3kayPztvOJR3toOi21ZOVetZhDPCz4hpYjBrQte+u45LuLDRdmMQKbprbJsxLjNtBsuGGHmYEG+zYbJSzXi7T9B4Qryz4CDO33VKnfUSTT8I+TlG9DLuT8ACV0y66LcMcRdM/N3+mr8kePC8TLw724v72nNoAix13Hkefj+59I3O8S9jQDgAmWZWTfgwkn19fYXWGm8dXQKk9u1VtcctuY/akUmCEnNyscJlikq7RH1OU0NB4RIETEStmfH0RLhFvBWngVpupfK/TSqvUydsFBUkCOulNUS6GavAq/WCsjK26RgGpCVat24PZljb3Ae4ihpPklD8xsrDQQqAimmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7A+y8l2gyLnAWM23L/J2w6I/1AKUWc7ubOBnlkuD28I=;
 b=b537qi0zufIKrlrE/WH4B9dE+ClUWaQGZdzDPPV1U1xiYrMh84df5rgtmFw2M0Jp315CsgIvTn4T08fYKOo2OEOk6Rubc9/ph7ZN7ZkWFD0VwewpW/U5IUoGOSwXKg3fGeAmuMZd4MkD4Q8n4y2rYI3gwgDUvjobaC6l/0CwpPd8HTqHO/HYKXlGE3L2IiGegY55fj2o9uBiB7E+YMxnyUx/Ql7AZXXKxkRGmSTM/nqHjUUNkMkDDUsCSmU3eHRcXV7jkOs7K+qs5mEapPt+h4OmM0yvD//cvp0dnfo+kNfyFpEZkIU0LP6qFJtsszJ2guEcL8Fg2ZBTKnyn7qYE0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Tue, 25 Aug
 2020 14:32:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 14:32:08 +0000
Date:   Tue, 25 Aug 2020 11:32:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        "Parvi Kaustubhi" <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
 deallocate
Message-ID: <20200825143206.GT1152540@nvidia.com>
References: <20200824103247.1088464-1-leon@kernel.org>
 <20200824103247.1088464-2-leon@kernel.org>
 <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
 <20200825115246.GP1152540@nvidia.com>
 <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
 <20200825130736.GQ1152540@nvidia.com>
 <74f893e8-694a-17f0-dc49-05061a214558@amazon.com>
 <20200825134428.GR1152540@nvidia.com>
 <5f4f67b1-ca3c-fd11-a835-db7906cad148@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5f4f67b1-ca3c-fd11-a835-db7906cad148@amazon.com>
X-ClientProxiedBy: YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by YTXPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Tue, 25 Aug 2020 14:32:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAZza-00EZk7-CD; Tue, 25 Aug 2020 11:32:06 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 057b7489-6159-48d5-51d6-08d84903a53d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4042:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB40429836C8683266E50FB331C2570@DM6PR12MB4042.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7/bJ2s+0DuZ+3Qsu3O8w7Kb2HhQC2zJ/6NeEcB87ms7a2WNRC2j/lXaTATZYqvjKQXJ4Dl9BFjuwh0xvlYT7X6ZL3A+3h+i+DSYMF07H9NlP65UgLomXdJBV7q5ywfKvtIZ1NHcl+3Jk+OL6Bxy7OFSLb127UnBkSRtTay+Beg2bneXDx05FJAqV/NMt0CVl/CnZlXFC3dTrID1s0z/7DijEjXPlGSfK0LfyndlDhEgIf6/bCHO0A95po0NS39OdJH7AYdBPAbzK+CoAJCxFyZ//3aSkLNddWBB/GU4VL6QviIEBHuSw8iKAc6rM4zuO6iYJxzi7rrM4ZIEL56S3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(7416002)(66556008)(5660300002)(36756003)(8936002)(2906002)(4326008)(66476007)(426003)(66946007)(9786002)(9746002)(4744005)(86362001)(2616005)(107886003)(26005)(478600001)(54906003)(186003)(316002)(8676002)(83380400001)(33656002)(6916009)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eDYyJGf7XuUClCXAqjddNw7hgYivrD3qOrM+HGWR76KNGacxe9hVbH8ZJ6V1l4uNEqMeD0BosioziRNuLcrvZy3MCwQbVW47OkUcdQqDd2D+Ny185El05wu4QPeQFbNgKnibob+zhczVAx0y0RRZTxaPlES5fb1PMeIkPTh4HE3NYmSthkuqIXIN7L3FsyWKWDva+kuX1NVmm9UD+louN9oTD0ircqbeIkKjSdCvDUW1/NiBMxuMzG6GeUvo+IxDJ/0yRZNumHJIVTzZIgpah+X07any69y1wRQTvpvoAIOOVr5+bvpCsV10mMUotqd92O+YIssPOYrGVKgNm0tgYx40K6wvqplR3DxHKlqjWsOdg1j1akGKPSYfawiNr7Z6OIP5A0TANaTRdMkW064nVb055APi/wFG6gMijD22Jxv+9QrD5TSq/8cg9iTxjAFOSGmcB9wYbtmg/erWYdV1vciyq02Xz5jmANBz2rjaAlplGE9emhZK/+fDr/7DdEub0E7DUIKIr0Bk32U13icm6uiWaZ3Nr2KNXd8jGJnOM7x6cUf9xc/fRBPsU6Gf7GV1wz4wHWo80QB+qJmOFGfjvgzflJDnqEBkLeVkzdB2q+a9EzNvrRHNDK4VgSuZQOiDV6liYEs8lIpDmZoMeUxt3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 057b7489-6159-48d5-51d6-08d84903a53d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 14:32:08.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQKsVjjWcHKrKC2Gw1O/qn4RQhNfirMSTMqEtIqDQK3+DXwsHLoQm+i098dtNrZB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598365830; bh=7A+y8l2gyLnAWM23L/J2w6I/1AKUWc7ubOBnlkuD28I=;
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
        b=AXi/x/3WOnf70slJOPGhWFIJ5j5rwWufHxTZOlv8eJ/be84GckXKolP1/MpaBftw6
         pC6Nudl7529MJSXdFXgIHU/pwQCWqAbhJLEIZnF2/EARc8YZ9HwbEHtXn7v4orLeHp
         EWUYgMd/uXUSodGQBWFdULEqZ7ceA3Pabe3XKvq5OE6GUAZw1FzRRQ2i+rcOPBAHKU
         sdxwpxIJEM2xoNGvU5G8CafZ5Uz0kgMdRDg5M42mbDwPWqT2t0zQMRDAllXFh+d34d
         zVedIpLeINhBWyg4kY1EwPNU9K5r8IC8YnIQAKuCEcwsau7Ht6F0R4sw1MKjRAc+nB
         Q4vu5gfpnOz/Q==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 05:04:14PM +0300, Gal Pressman wrote:
 
> Right, as always, the error code would probably not contain much information,
> but there's a big difference between returning error code X/Y vs returning
> success instead of an error. To me that just feels wrong, at least in cases
> where we can prevent that.

From user perspective it is a success. The purpose of the destroy
kernel command is to allow userspace to release the memory underlying
the object.

The only valid reason to return a failure from destroy to userspace is
if userspace has a programming error - eg destroying a PD while QPs
exist does fail today for all drivers.

Userspace should treat destroy failure as a serious error and crash -
there is no possible recovery from it beyond leaking memory.

Userspace should NOT be exposed to device failure via destroy. Failed
devices trigger an ASYNC EVENT and destroy MUST succeed after the
device fatal event.

Jason
