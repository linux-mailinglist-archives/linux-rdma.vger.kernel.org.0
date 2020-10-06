Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B126284BEE
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgJFMqa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 08:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgJFMqa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 08:46:30 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA097C061755
        for <linux-rdma@vger.kernel.org>; Tue,  6 Oct 2020 05:46:29 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b69so9812241qkg.8
        for <linux-rdma@vger.kernel.org>; Tue, 06 Oct 2020 05:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Oei6x3FYoQO8SNOZlW1qBYhs+2XgFUxEWsaHHrSu50E=;
        b=dQI7Tnb383TS+eryKHtFnNf2Sp3QRLjOcoTwu9uIpDrjuHAKFNuKG5DBn6rOO+qiF2
         RLVCbZ49bsvniuddK9uu+flnovGgp2dEPewMjUCc47IpkrPdfP4S9ufTrAIb1BlmLUFX
         Hq2l38U0drl0WtlVXLpGwicgT7o/EnvCNhoYZwxQt6h/kzwKev0lypjA0JBFTt69bneM
         6i2WNHCSG7uZXbMQH7qL4FhSkXnnOo+Q4T4BaxPDBQrzedJRFNxuajrAc2EmvV6rLMtJ
         kp2UupXVUbLVb5tVnNcEao+WxjJc+AKhqhxp+kUCYZHgf7WVOt5VocrGDxMbtt9+E6fd
         Tc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oei6x3FYoQO8SNOZlW1qBYhs+2XgFUxEWsaHHrSu50E=;
        b=WrGcpmVxE9pdcf5aaup64Fyo3ebUduQb8adRy5mKFtiwrVPcsp5XDsMo+A33C2y2IW
         9PIqjcfxsNNgk/k7+q59t4rC1D26Tqgf+K828S08B0vvEtlH6si/sLMkqKb3K5vor0RK
         BHA3no8ZpR69R/iw/zR4i2UoIqMbT83kPciWyIwqknZtLl8boLrcugrAXbdgbNUX9Yi9
         WCsyh5asiSht/I1y+KtgAeEMm3URnKab9ZSn80DhxD8SU97PW2q9x93fqZxgwLUs4gr2
         wRRVy13rhEvn6/zvFnUEcnBYsPHlrAepP7+MYzU3DpfSYvK6TZ71f7lCjhRYWpGi2j7+
         KQKQ==
X-Gm-Message-State: AOAM531UaSLUKQmbGEwCeNDnmtxDT+ThDOqR88W2oEyvI7gP6mq6g5G0
        UvsgbvS4vCgbYTT9Ct9SJqtPyw==
X-Google-Smtp-Source: ABdhPJxNOcrFAfAWzHcXVhP7DDtF2Ic5Rt7RroDeaVCSX8uE4/H7xiOevBPj5a5eNwr0UpeMSkUcHA==
X-Received: by 2002:a37:4854:: with SMTP id v81mr461696qka.20.1601988388938;
        Tue, 06 Oct 2020 05:46:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id o4sm2484865qko.120.2020.10.06.05.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 05:46:28 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kPmMN-000WQj-Kt; Tue, 06 Oct 2020 09:46:27 -0300
Date:   Tue, 6 Oct 2020 09:46:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ka-Cheong Poon <ka-cheong.poon@oracle.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: RDMA subsystem namespace related questions (was Re: Finding the
 namespace of a struct ib_device)
Message-ID: <20201006124627.GH5177@ziepe.ca>
References: <20200929174037.GW9916@ziepe.ca>
 <2859e4a8-777b-48a5-d3c6-2f2effbebef9@oracle.com>
 <20201002140445.GJ9916@ziepe.ca>
 <5ab6e8df-851a-32f2-d64a-96e8d6cf0bc7@oracle.com>
 <20201005131611.GR9916@ziepe.ca>
 <4bf4bcd7-4aa4-82b9-8d03-c3ded1098c76@oracle.com>
 <20201005142554.GS9916@ziepe.ca>
 <3e9497cb-1ccd-2bc0-bbca-41232ebd6167@oracle.com>
 <20201005154548.GT9916@ziepe.ca>
 <765ff6f8-1cba-0f12-937b-c8893e1466e7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <765ff6f8-1cba-0f12-937b-c8893e1466e7@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 06, 2020 at 05:36:32PM +0800, Ka-Cheong Poon wrote:

> > > > Kernel modules should not be doing networking unless commanded to by
> > > > userspace.
> > > 
> > > It is still not clear why this is an issue with RDMA
> > > connection, but not with general kernel socket.  It is
> > > not random networking.  There is a purpose.
> > 
> > It is a problem with sockets too, how do the socket users trigger
> > their socket usages? AFAIK all cases originate with userspace
> 
> A user starts a namespace.  The module is loaded for servicing
> requests.  The module starts a listener.  The user deletes
> the namespace.  This scenario will have everything cleaned up
> properly if the listener is a kernel socket.  This is not the
> case with RDMA.

Please point to reputable code in upstream doing this

Jason
