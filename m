Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 836D2102C2C
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 19:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfKSS6z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 13:58:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39766 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726939AbfKSS6z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 13:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574189934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gFWTHuIB+L6IZSct+FIzo+M5q3SYg/8/nPaBMk+3VaU=;
        b=AQbhOkW9xl9SMxD6jF+ytByFSscsCtEsDGnnpUZyYH91sQ2tLDTUhhzHH/dSO0lZxzVGYF
        t5WqJ89+cUrDR0kv5KjsiaJihB495DXCOIgcVGP3vyYjqhgQ8sLgjweN7DeDR+uOIJWOm+
        qnKVfr15QamYKrgndjyjg2LHnt7K26Y=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-DNT1VujGOwyooLM-KGKRCA-1; Tue, 19 Nov 2019 13:58:50 -0500
Received: by mail-qt1-f199.google.com with SMTP id n34so15272802qta.12
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 10:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EjrhTZUF7jtDysVYJRqGuNLeGXSR7KDqe9NefhbwW0U=;
        b=K7Tjki7bQBgX3oENH/c0h7azTcCMvuz+VPl1pELwmuzlf/CEhQiPAruMu6PGXkSNcd
         FVRQ4H4EhaCCRaICCjVXsM4WN+DcITVsmyQrY8evc2qMdLtkUEMkK9xm6DXQ/jJshohE
         Ic0eQJYD3V60YhkLGbyOLchY3/8JGt9K0XURflSHySdwwoqHHhxKr0Q9O8Fu0nSDKL3u
         G41DSGgbT4IWtDu1pmHkxnX5KRcKeIWs+wQjM3qvO1HgYhbD6HafWC4eNDO43IxgA+tv
         d+k1yANYhNyGdDF66mvugKtOghxg405i/agMk7VSPtVP+cOKHASJxMbjgBCTXIlm4hjn
         SLkQ==
X-Gm-Message-State: APjAAAVg70BmS9LG/qLpjl3AAII72r5iWiY0EPoXeZp/ClD0uLfPK9F0
        DUFn0CSYGlfSnY4cqM+LPUOqXcoLmttS68nlFf1bpm/wvGDqig7pTm7apP1TKbUDQtsroVUNMa4
        mVmrsuV71FBtCSEda806Eog==
X-Received: by 2002:a37:3c8:: with SMTP id 191mr29472492qkd.77.1574189930455;
        Tue, 19 Nov 2019 10:58:50 -0800 (PST)
X-Google-Smtp-Source: APXvYqwnBZAF+Wt1CXxfcMn6Q/+Z+4iK6XGfqiua/IbAXSkx+t9b7Vkf5iIeIpKwNaUzLal2VrJvnQ==
X-Received: by 2002:a37:3c8:: with SMTP id 191mr29472450qkd.77.1574189930141;
        Tue, 19 Nov 2019 10:58:50 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id y29sm13298234qtc.8.2019.11.19.10.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 10:58:49 -0800 (PST)
Date:   Tue, 19 Nov 2019 13:58:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Dave Ertman <david.m.ertman@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "sassmann@redhat.com" <sassmann@redhat.com>,
        Kiran Patil <kiran.patil@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>
Subject: Re: [net-next v2 1/1] virtual-bus: Implementation of Virtual Bus
Message-ID: <20191119134822-mutt-send-email-mst@kernel.org>
References: <20191115223355.1277139-1-jeffrey.t.kirsher@intel.com>
 <AM0PR05MB4866CF61828A458319899664D1700@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <a40c09ee-0915-f10c-650e-7539726a887b@redhat.com>
 <AM0PR05MB4866C40A177D3D60BFC558F7D14C0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <13946106-dab2-6bbe-df79-ca6dfdeb4c51@redhat.com>
 <AM0PR05MB486685F7C839AD8A5F3EEA91D14C0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <ead356f5-db81-cb01-0d74-b9e34965a20f@redhat.com>
 <20191119164632.GA4991@ziepe.ca>
MIME-Version: 1.0
In-Reply-To: <20191119164632.GA4991@ziepe.ca>
X-MC-Unique: DNT1VujGOwyooLM-KGKRCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 19, 2019 at 12:46:32PM -0400, Jason Gunthorpe wrote:
> As always, this is all very hard to tell without actually seeing real
> accelerated drivers implement this.=20
>=20
> Your patch series might be a bit premature in this regard.

Actually drivers implementing this have been posted, haven't they?
See e.g. https://lwn.net/Articles/804379/

--=20
MST

