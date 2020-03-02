Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43B4817615B
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2020 18:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgCBRoB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Mar 2020 12:44:01 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36342 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgCBRoB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Mar 2020 12:44:01 -0500
Received: by mail-oi1-f196.google.com with SMTP id t24so73585oij.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2020 09:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dNYh745W5kmdbqIPKnH/LXvfdVacdCVejfx31yl0yhs=;
        b=uclBysVL7xNngGjfgKH5JelCmk5seRkJ9fYH/B8nWEaEe2Yu/hZE17HI8pBiRYrm21
         I88kWRZC3xfqe6IK+lE1ZG5FtpOa/ypO+k3fLIGg3GquRuve/WAfAPAro+AK89wNvfGI
         DbVcdSHnwjM7VdBPGzbgpRSyFPABPKegWiK3ygmvudGNIJo32eX5WywK5oMhdI/M3+c9
         BjTN0uqQSHGxhr1f59IowCtlpqhauSDgMnf04SIovwc3nuysRte1Us5+vE+Jv+8uNvP6
         3OuQAPzCr5AYZW0EiIdmDACYafKwsBqXKuqAYxzLCDP2OADpWFWoLcmwrtVOpKjLC5G6
         KrDQ==
X-Gm-Message-State: ANhLgQ2ZdNOPXARyZ4rF8xZkKlDEppybfHDz2xJ4bEwXvxHX3yQwx6b1
        kxEDJnszcYeqUI45wIO/jGo=
X-Google-Smtp-Source: ADFU+vvWMYBvKZRzMQujbzfZfC/OHszWtExDqb2WiOAsxYeSMC7rYVgWKnjM1NyMGzgl8mjMAXGQ6g==
X-Received: by 2002:a54:4487:: with SMTP id v7mr177416oiv.106.1583171038809;
        Mon, 02 Mar 2020 09:43:58 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id r26sm1198295otk.65.2020.03.02.09.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 09:43:57 -0800 (PST)
Subject: Re: [PATCH for-rc] nvme-rdma/nvmet-rdma: Allocate sufficient RW ctxs
 to match hosts pgs len
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>,
        Max Gurtovoy <maxg@mellanox.com>
Cc:     jgg@ziepe.ca, linux-nvme@lists.infradead.org, hch@lst.de,
        linux-rdma@vger.kernel.org, nirranjan@chelsio.com,
        bharat@chelsio.com
References: <20200226141318.28519-1-krishna2@chelsio.com>
 <b7a7abdc-574a-4ce9-ccf0-a51532f1ac58@grimberg.me>
 <20200227154220.GA3153@chelsio.com>
 <aeff528c-13ed-2d6a-d843-697035e75d6c@grimberg.me>
 <7a8670c0-64bc-7d7b-1c7a-feb807ed926a@mellanox.com>
 <20200302073240.GA14097@chelsio.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c8e3f76b-a255-ba03-dcb5-32d8042fc8a0@grimberg.me>
Date:   Mon, 2 Mar 2020 09:43:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200302073240.GA14097@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> Hi Sagi & Max Gurtovoy,
> 
> Thanks for your pointers regarding mdts.
> 
> Looks like fixing this issue through mdts is more natural than fixing
> through RDMA private data.
> 
> Issue is not occuring after appling the below patch(inspired by Max's
> patch "nvmet-rdma: Implement set_mdts controller op").
> 
> So any consensus about merging the fix upstream, to fix this specific
> issue?

I think we can do this asap.

Max, please send a patch for this.

Thanks,
