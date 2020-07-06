Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46C8215D4E
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jul 2020 19:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgGFRhT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 13:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbgGFRhT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jul 2020 13:37:19 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027E6C061755
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jul 2020 10:37:19 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id r12so26415391ilh.4
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jul 2020 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m0xCygx5ruKIFHug2KjFmP4r/RrXsW/OklV//LBVvbs=;
        b=couY7n4b8wfJi6invmwVNWQhRL8kEseQ4TU6Bu4bR9WWuKY2bbtjttp2kch9h+nKpV
         0Fplt2FAgkUaKFbI8lgEwufF2heRZ6v12282qsF8SmmBV51OVMSf27ramD+w/wLpRDBG
         7Lrj0uKXzBrxTp0tnG1c+7s0LCD0sbA0YIh5Fouvien+Q4Tb/621/A1a+vGQUuHj6shF
         0h12altk6eYpt5YJwYVfdzHy/wPZAoo9jw5WkN+XnXBdbpmdjz99uSCIGc1QempSfEMe
         Fsc66eaEv9s0zKfL6FdYlBtn6gj7yTmYDZXZ4kzhoz4vLG1FKsuC900n5OkZA1r3JTwg
         bNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m0xCygx5ruKIFHug2KjFmP4r/RrXsW/OklV//LBVvbs=;
        b=GDpAi/a/ojUkGFejw43N+FC8Ul4d9uAVaAPw498GSOsrWqlfzis6KdQ+oUkgUXu0bN
         B55TyR8ncYPScbl2mlP2RvewlB3tvDDnblKEN3HZABhJuUAIDcVcMS4SM1bvV+HV43hW
         O+PjCFs86rTeK7ClOOdJMI80gK0rls4VYaQoCGkrFMIK664ZC0uCFf4bEvdgPRW+BKXK
         8IvgCT1nZzVMM61e5P762SDRgMSdJDtvaU9wZOemMR3kPraZLpddMjdUfC1ZTvgq3wH2
         zbGS3QjEMJXroktqBLaQ7K2kuY4lHk4Rn8MuQMeJmQLl3XhZtK1BAWeOAFOZ1yjSyR4/
         6BSg==
X-Gm-Message-State: AOAM533pw84DuOEbrwSpLLGxfERPhzTvm+Dt16/ccn/8WxvBYtfpWPNo
        GsnOReTSwzhNcumHyHJpfQnHySMdIi74JQ==
X-Google-Smtp-Source: ABdhPJxjm5GjY1LO+B/S7uFKqkqQNf5H5c1YTkkr5V8HrIzph2aYywxxSQIfzZJSMrrRixw7agn3EQ==
X-Received: by 2002:a92:c7b1:: with SMTP id f17mr30900954ilk.193.1594057038442;
        Mon, 06 Jul 2020 10:37:18 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id i188sm8122689ioa.33.2020.07.06.10.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 10:37:17 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jsV3M-0055TE-R0; Mon, 06 Jul 2020 14:37:16 -0300
Date:   Mon, 6 Jul 2020 14:37:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michal Kalderon <michal.kalderon@marvell.com>
Cc:     dledford@redhat.com, aelior@marvell.com, ybason@marvell.com,
        mkalderon@marvell.com, linux-rdma@vger.kernel.org,
        Ariel Elior <ariel.elior@marvell.com>
Subject: Re: [PATCH rdma-next 2/2] RDMA/qedr: Add EDPM max size to alloc
 ucontext response
Message-ID: <20200706173716.GW25301@ziepe.ca>
References: <20200706172817.14503-1-michal.kalderon@marvell.com>
 <20200706172817.14503-3-michal.kalderon@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706172817.14503-3-michal.kalderon@marvell.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> @@ -77,6 +79,7 @@ struct qedr_alloc_ucontext_resp {
>  	__u16 ldpm_limit_size;
>  	__u8 edpm_trans_size;
>  	__u8 reserved;
> +	__u16 edpm_limit_size;
>  };

Padding must be explicit

Jason
