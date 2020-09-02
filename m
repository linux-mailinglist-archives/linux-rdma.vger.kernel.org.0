Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C2525B40E
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 20:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIBSou (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 14:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIBSos (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Sep 2020 14:44:48 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2866C061244
        for <linux-rdma@vger.kernel.org>; Wed,  2 Sep 2020 11:44:47 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o64so652562qkb.10
        for <linux-rdma@vger.kernel.org>; Wed, 02 Sep 2020 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Uaw7EAc1T0wiCA0boDt9Q0yp4z3meCIAG/a30Pkhuqw=;
        b=DsKlrz/zKqWQW0FlQfXjh9u3wYSB98a9iAumjK5pWIRhl3Y79xV4q5Vs1v4uWeJQ41
         /NYLGM+A4Am0+bn2avdMwHAo5zlVTWfNvcQbKggHfju/CoGDxRmqoKNWwJJrxh1Kxs6C
         YQ99ScKU6cLvEFKDOZXRZvQJ6dqTmmdf33Agnf0QochWQtcnLQNyO7witJ/IgfxWCoG3
         YnIIKX1gRyJkQ9mMWF/ZXBIbGZRnEbKQRX0uU7xXV5ir4O2H37qxQonow3vrQScCmc3+
         aaRZz57lhZRCSieLhyNVXsHpHprrAXiDksOBURqQD7KpZuqsUEGqyvOss2fPw5ih2W+V
         YOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Uaw7EAc1T0wiCA0boDt9Q0yp4z3meCIAG/a30Pkhuqw=;
        b=IY1l6IUgHSb+Ji7ffSvN9Y9uXwuvmy88rym5mAg7obfUONAMxu3Lv7INms1yo6djX+
         9ndkP47sbQHW37Zs5lYnsl5So860eUq+5ZUUj0WgHzXni76RNRlxWVUYOFkRMIMPg0wK
         OBjRIrKKxiIta46VHfNn2gGTfZ1lBoCW/G+LJx3RYvhgo5buG5ELavcwf6NDsH+AVfzQ
         KK+n9oCNCa8MHylUxME/6bufFvbGZlAW0MXKSFDN/MqxOENiQofdCwF95Bh+xn3VXElE
         3W7eltRMJPmp68gBDgYtTAXriE4+gmsnFnAZATu75S/CRhsXJmz/2gIrFJXJCeIfWn3d
         fnCQ==
X-Gm-Message-State: AOAM5326E+Fa2PNq8yytVGfbFeLAwuXXTZH6vYxWlbKmD9C25g/5EFXd
        doaUdasqD+JFS1sknBk7EAwsfA==
X-Google-Smtp-Source: ABdhPJwwYvf2u9nKp9j67lJBlKbwUGVBn64vsv1pKZ82Qqg31c7fBOenfh+JaVs5HzFan91SJQ+qEA==
X-Received: by 2002:a37:6892:: with SMTP id d140mr7948862qkc.58.1599072287268;
        Wed, 02 Sep 2020 11:44:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t69sm357981qka.73.2020.09.02.11.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 11:44:46 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kDXkT-005xOi-PO; Wed, 02 Sep 2020 15:44:45 -0300
Date:   Wed, 2 Sep 2020 15:44:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <mkalderon@marvell.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [EXT] [PATCH 07/14] RDMA/qedr: Use
 rdma_umem_for_each_dma_block() instead of open-coding
Message-ID: <20200902184445.GG24045@ziepe.ca>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <7-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <MN2PR18MB3182083A47A868B1FB781F44A12F0@MN2PR18MB3182.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR18MB3182083A47A868B1FB781F44A12F0@MN2PR18MB3182.namprd18.prod.outlook.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 03:36:00PM +0000, Michal Kalderon wrote:
> > +		/* If the given pbl is full storing the pbes, move to next pbl.
> > +		 */
> > +		if (pbe_cnt == (pbl_info->pbl_size / sizeof(u64))) {
> > +			pbl_tbl++;
> > +			pbe = (struct regpair *)pbl_tbl->va;
> > +			pbe_cnt = 0;
> >  		}
> >  	}
> >  }
> 
> Thanks,  looks good!

After this series you should try adding ib_umem_find_best_pgsz() to
qedr, it looks pretty simple now..

Jason
