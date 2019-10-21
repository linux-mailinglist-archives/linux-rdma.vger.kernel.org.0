Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46327DEEFC
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 16:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfJUONO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 10:13:14 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33736 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfJUONO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 10:13:14 -0400
Received: by mail-qk1-f196.google.com with SMTP id 71so8862777qkl.0
        for <linux-rdma@vger.kernel.org>; Mon, 21 Oct 2019 07:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pdfbJ18DbtGn1E0W/FCiKxCISHOgwlLZF08b9AdE648=;
        b=Hq2oNdCxlIHPxeWoU9oyidsHwEDOp9zIuGipxbltcoIG3ux88dzfq3XZA09ONbqd3e
         tXRCYVnhFnHz8MY59FCLsPT6m5b63ZSd7EzEQ1+0RblD0JoaEAEg1OXBVnL0Uaogdqdf
         UUf3fZNgPfMbeGBjRRnjThwEQlOwCMbFsE8T5vi8O2CypCXHLdgDhjgFbbreF0gcabdH
         2v/kfQ48Tb3ZjNvIk3XxvWOK41jDrpMLO2AzVhyfqty0qoMQ0uuR7QP6aZjuWeUCkirs
         FAEqwH9kKg7a5aJVWMIlUjpt+ABQ0DyaszEhTP3BgqNtlv7mLcvGPbxBcB6fE3ZtZ1QM
         4+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pdfbJ18DbtGn1E0W/FCiKxCISHOgwlLZF08b9AdE648=;
        b=RZzUJimoB1B1RRTDZfi94znijVV8YQnkFnP4HbKss9iRDHRS84kMdQOHoiueDcGN7C
         2yNMVp3NbzHDaToOaTS9kjiURnFzMeZYz7vRL7AI7eN8pxnND/VYiQkz5nykjsl+FIaB
         kG1DMz8UI4Qs6kZPhYfN+4nGTkvSFt91EdgjcLhvZqa3E1WsDCu7zuRq1GgBVP4kgCdR
         0wQlNQLZtwOT/Y+afwml5mIDem3I50SgLQ1JMDJorvjIfYmcxoOSveuJuSQCpAIll7ig
         TiZrsIzcZriVXktSGQNBZjQM+L5HQ03pPujyYGvLlBSthPiuWYIHDXPfsgyqCgKk71GD
         6iZg==
X-Gm-Message-State: APjAAAXeJGDp0e2b4gTaZEXnsZ66h1gCMLE2cYLAWO6Yh2Ipck77wqiE
        wbTAdmDO57NTrefR8eNK4sAnKw==
X-Google-Smtp-Source: APXvYqwIbQOkT8I2DhefK2w7FZS0Ha0eQKnGlJTa4dqlaBFkLRMBwWV3y9MuW4Xk6F6NDBnTiUIVCg==
X-Received: by 2002:a37:610f:: with SMTP id v15mr12161114qkb.98.1571667193383;
        Mon, 21 Oct 2019 07:13:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id c8sm7276641qko.102.2019.10.21.07.13.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 07:13:12 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMYQq-00086f-81; Mon, 21 Oct 2019 11:13:12 -0300
Date:   Mon, 21 Oct 2019 11:13:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lijun Ou <oulijun@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [RFC PATCH V2 for-next] RDMA/hns: Add UD support for hip08
Message-ID: <20191021141312.GD25178@ziepe.ca>
References: <1571474772-2212-1-git-send-email-oulijun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571474772-2212-1-git-send-email-oulijun@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Oct 19, 2019 at 04:46:12PM +0800, Lijun Ou wrote:
> index bd78ff9..722cc5f 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> @@ -377,6 +377,10 @@ static int hns_roce_set_user_sq_size(struct hns_roce_dev *hr_dev,
>  		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
>  							(hr_qp->sq.max_gs - 2));
>  
> +	if (hr_qp->ibqp.qp_type == IB_QPT_UD)
> +		hr_qp->sge.sge_cnt = roundup_pow_of_two(hr_qp->sq.wqe_cnt *
> +						       hr_qp->sq.max_gs);
> +
>  	if ((hr_qp->sq.max_gs > 2) && (hr_dev->pci_dev->revision == 0x20)) {
>  		if (hr_qp->sge.sge_cnt > hr_dev->caps.max_extend_sg) {
>  			dev_err(hr_dev->dev,
> @@ -1022,6 +1026,9 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
>  	int ret;
>  
>  	switch (init_attr->qp_type) {
> +	case IB_QPT_UD:
> +		if (!capable(CAP_NET_RAW))
> +			return -EPERM;

This needs a big comment explaining why this HW requires it.

Jason
