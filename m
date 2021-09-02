Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2C23FF05C
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Sep 2021 17:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345842AbhIBPlF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Sep 2021 11:41:05 -0400
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com ([40.107.94.49]:13153
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234480AbhIBPlF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Sep 2021 11:41:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7htCRZXpOK+ifFzePawluBQ3YFel6gZn5BWDXQUWZlGyIVBBTGiYWxMrvk8CXciZWC3MrFiP3+upfYsQuZn8hWe7kMhbfZmgGNFYKds472+b1D69eGrKXNYorQiOuEPN+8HiKaOYFoI4ThnrUZ9gHOxG6EOL3lwhCAd8qm4pW8Qv/Jxjj7XACZr+THz2Ak7XH31bmDtgNZttPIAaCb5ApZlRirz2RdRhJPXus75fKGeRJKcNGcWOMuxLYmNoyaxjqjdg79ASFwJpIeq91XMfy+KEB06/qBRxDwGdiU5X4bnFfC4fcUABOXYHTIjrFTOW3jxaIsGN6mvgy3eJknrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=drKP51tDV45iEV/GwaQFxdh+GjHKg+Vwrb86zt5BiqM=;
 b=nSO7BzonmiDj1vaCvmJDwcwNmQt5mquYMT1I77+oiTyLq3j8vqPuQAyZ/QN2lbAVc+KLlwvhkIDdXMSl/fQQDSwQ26N7SMeIlGS9QlI7QhLcnXMONwy9ZeqcYYwDeNDML2QlBtyPedoKMEjBs8PapAfVYLD4oqRmXFEXjVtwXF32Zx1U1etOKHplG8vA7vEigoWtq44byaMDJGtkwKCe8v3RBE1a/TKSkmN9YFTuqUTm87ehf5w+QCMZMs/YDSiLTm5p+aSqK1BpJa2UZoUKzrJy+/qmjM1FSFxAwCpjlOI7J12FsBYrU/xFeDZlek54zlwCHWYQyGHoSEaNdS8WQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drKP51tDV45iEV/GwaQFxdh+GjHKg+Vwrb86zt5BiqM=;
 b=CqBg2zjBeDyXxjIVIzt9lswj/ddYWhxf5kIy6UPArwbziqdcZOMAi12LOn3PAGTuVQ/mZd1IvvpzRBvZhoJk9FlmFK+CUC2CdZvbcgEJnYv8pnn08SWt1/8YR8CmjdDGqg9Y98WFzCzX7amd8uMzPByhESY1s5nIddWNMEcL+EncUBvaDVU5mrOouE0dbsAjUeXSsIXm5kn7lj2bR4Wjo1vorHL34J51iFZhV8QXh/BRnUgPG5Fq9jmzPcmMEIrVwOUL6lWUiuzqAWdqwNGcCU3HwktYRBPs6FeT6Tgw7VWJ/aMe+sYXQrdYeGUzcpMnpY7gq0PXuZpFHVYSh0l+4w==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Thu, 2 Sep
 2021 15:40:05 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.020; Thu, 2 Sep 2021
 15:40:04 +0000
Date:   Thu, 2 Sep 2021 12:40:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 rdma-core] irdma: Add ice and irdma to kernel-boot
 rules
Message-ID: <20210902154003.GW1721383@nvidia.com>
References: <20210823154816.2027-1-tatyana.e.nikolova@intel.com>
 <20210823161116.GO1721383@nvidia.com>
 <DM6PR11MB46922D3AE92E34B4E1D3AC9FCBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB46922D3AE92E34B4E1D3AC9FCBCE9@DM6PR11MB4692.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0254.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0254.namprd13.prod.outlook.com (2603:10b6:208:2ba::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.6 via Frontend Transport; Thu, 2 Sep 2021 15:40:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mLoou-00AMNk-04; Thu, 02 Sep 2021 12:40:04 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cae2de66-dcc2-4eea-2956-08d96e27ef59
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5045FE85C6043D9EA394002BC2CE9@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94ZJPBvsx09i5wE1/kyzkRXVrGk1x8Ola7a+YqZjERWZH2FcYFg1t/YEo+E/wfjdPVUQwKMGwVb4e9FA6oEhwqunTDZk5hydezxKrkLh8kVs1nvSxgd7EBSLAn5kPt+zgoWqVikV/spp2VHSZOuNzuWSLG+48YH0KqJg2hGT9+ajAd2oZHCBSK4puQE/veAtveuKq/QIJYPfp/uOsLWW9hOdfVgzjg2piSY++Y9II5s9ues55IJl/QqK4dPtmg2QNU4PkzK5MBx+B/GPh0EPzhhZ1N4P5X8qFxE6iRdgjuPnlRNH1U6tA0hQHMpj4bBwTCVxsS0GPtgJYiEMidOC59wghuW4TpCUCBRucOZGGYawunvAr3DQDgnC9cIPXS4q9nGbmIchltDQp6QN/ckiZ2PKiKaS2BauFR7irrzvOm2mvT8q/mz2Z0eKXeJAeEfEqntkKJiltclz+HMixXqoQZTQcVKkgbxWNGW2jFOY0NfNA099qcJGdo/ermtlG21F+EaV/jgGy3yzKjl8C6Wncn+KpovFgZtVM51+wFMV6rVatqVeGpgy9qaZi0gHyXD5Q60mm8aqW7V4+DYcVmJZ+hmBreWaTZ3wQeDGvEs3mEShFar7XDUL+21TpvNi8Ivbi45A6eLHDhy5Yoxw2NyK8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(4326008)(66476007)(66556008)(66946007)(478600001)(426003)(33656002)(6916009)(2616005)(186003)(86362001)(26005)(83380400001)(5660300002)(9746002)(9786002)(54906003)(36756003)(2906002)(8936002)(8676002)(38100700002)(1076003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e3KmPKSdOzaUyug5U5LyxtYmf9UkX+1scA+X1o45c2steuSDloQpnktJjbqB5LnByL0NHdW8+UQc4A9nZo09csGPn/IYqVDtpb6uMbxiWZLGy7KQjeX8oHB37TcdluInkz++d9mhv8+zLE8/jKnMIPO+lRICqoX1vR5qhv/23ywrpDBuFsrH5CP3ftz8+l+ojPNT2fg4O8uDaj538br5dIsc1krVPBOKLe7tPnWNWybhWQGdDx+/942Ufgl4AJ/zD1fbPDFm2aB2EWdkmLn3WRleQiqfhrrp2o7h8fhHNvpFBi3R00PEpRgTx09wxbhlVNKwu9zXT1CCJxg2cNW0AsexN68DQVayJSVdsuzFeiyMZFvpETH0esU0QuAdk3Z6WxizP5qwYWQlZpANfX3tBvGvaGMA0e3zhks9jOBJvZeP5WrzgmLDCWztk3B2Kf5EJoVEY7ed1A+TX5w0m/MtCGFRL13I4XOnvOAdYw0xVIzS3DkEvGsmqw8pgfcbIzR1lrxTdZdlm+KLRcYln/l0MFbxXUknRHq87Bhm1K90dT1OaM9Bmz5tjPJ2N35AOoKdfa1A5IqYlm3na+WsZv2bjZH/oyFQ7sa0p/06gkEyzmQsLXvdIltJ/D/SNN4WM8q0QFwxT5KCMs9QiOQnJUwK1g4kz4U8zgA2/uypUvvgjbyINWhbL1rwzCpcJ74UwpbzYtTVUAvxPnFrow2ajSzwNRSrMixjVo/0RCxr27q9pz80nAV/a4Q8zGlthrPW1GH3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae2de66-dcc2-4eea-2956-08d96e27ef59
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 15:40:04.9288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRQuaazO3JOG4hn+jF9nX4dmzfAsadf/uyzkzuCqbBbElJNUd2OLWPZVwjm5hqNK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 02, 2021 at 03:29:43PM +0000, Nikolova, Tatyana E wrote:
> > Given that ice is both iwarp and roce, is there some better way to detect
> > this? Doesn't the aux device encode it?
> 
> Hi Jason,
> 
> We tried a few experiments without success. The auxiliary devices
> alias with our driver and not ice, so maybe this is the reason?
> 
> Here is an example of what we tried. 
> 
> udevadm info /sys/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> E: DEVPATH=/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> E: DRIVER=irdma
> E: MODALIAS=auxiliary:ice.roce
> E: SUBSYSTEM=auxiliary
> 
> udevadm info /sys/bus/auxiliary/devices/ice.roce.0
> P: /devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> E: DEVPATH=/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0
> E: DRIVER=irdma
> E: MODALIAS=auxiliary:ice.roce
> E: SUBSYSTEM=auxiliary
> 
> Given the udevadm output, we put the following line in the udev rdma-description.rules:
> 
> SUBSYSTEMS=="auxiliary", DEVPATH=="*/devices/pci0000:2e/0000:2e:00.0/0000:2f:00.0/ice.roce.0/*", ENV{ID_RDMA_ROCE}="1"

What is the SUBSYSTEM=="infiniband" device like?

This seems like the right direction, you need to wrangle udev though..

Jason
