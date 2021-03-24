Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BA2347DB9
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 17:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbhCXQbJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Mar 2021 12:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhCXQan (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 24 Mar 2021 12:30:43 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FF3C061763
        for <linux-rdma@vger.kernel.org>; Wed, 24 Mar 2021 09:30:43 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 7so18611935qka.7
        for <linux-rdma@vger.kernel.org>; Wed, 24 Mar 2021 09:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4oc+u8dCwxGu7G/q2YHf5Bc1EmkcG17uqVRmUBQP8Es=;
        b=JozEtWHkJJXo6SwwiUsfcTPBo+WicVHlutUIXpuCKCAj3HuIZUJj209MDoRGyYldOi
         47OkZplzfTzPk8LmfoisOXOprQeLvz+yyUxlq9ZixY3LlIFIhC09eldKSlu2FXCMLwEm
         7BQ3Zx0t2XQGpxnSZggqmH2pmuJlnxMfuwstE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4oc+u8dCwxGu7G/q2YHf5Bc1EmkcG17uqVRmUBQP8Es=;
        b=oj51Y2ge7M3+7yvnazM3ZHbpqW8rljvrsEavV9KCP1aXCSd+9XCWyPuaWrEsZ4wlv+
         Qnc0eEso+Bc55+6tYGPDWkdEyqtsYT5O5nluTrMga1bOb4JuE4sLsJ8M6CXdgFEaDzOM
         l9CgmAxgrEfUJ0FSzibDpvyLSx5XrHn+q5RBrHwbed/+pl9Trljp88mSwAu1nEHtpUok
         q6B4MiMfWhUv3jxQHusv9IS4OQlQ0onSQvmhj9pi17xrXVIe/rJ4SQyNdyrri3TVK7+m
         DWIllVi2hIvce8ztlHIJbTAbzMmEtmXPnLAlRBI5z+fv2iYki6NQ2KRU6uhuVgZmNNVU
         6h1g==
X-Gm-Message-State: AOAM533D/S1Au10oVF/3wMYHMxEePi1mS6FO8K1GhI4q794G0pMInWDO
        UoukFBY6Mjg0GppNs0xHX6zUcW6rFyKaNiGcnFEErA==
X-Google-Smtp-Source: ABdhPJxXLKoBdwvhGVIzLxt0TRjp5MK017JgIqq7VBLPFijHtinE99lCHGVEmioih2QMaFQPh4yU82dlCQ90pxe7v3k=
X-Received: by 2002:a37:d47:: with SMTP id 68mr3927818qkn.169.1616603442165;
 Wed, 24 Mar 2021 09:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210324142524.1135319-1-leon@kernel.org> <20210324150759.GH2356281@nvidia.com>
 <YFtXw+w7MZFynam0@unreal>
In-Reply-To: <YFtXw+w7MZFynam0@unreal>
From:   Devesh Sharma <devesh.sharma@broadcom.com>
Date:   Wed, 24 Mar 2021 22:00:05 +0530
Message-ID: <CANjDDBjKbDkbwnWV=kk8m2J_NdwjOir0Uoj2xahwEMVDfu-5CQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next] bnxt_re: Rely on Kconfig to keep module dependency
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f135b505be4ad1b5"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--000000000000f135b505be4ad1b5
Content-Type: text/plain; charset="UTF-8"

On Wed, Mar 24, 2021 at 8:46 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Wed, Mar 24, 2021 at 12:07:59PM -0300, Jason Gunthorpe wrote:
> > On Wed, Mar 24, 2021 at 04:25:24PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > >
> > > Instead of manually messing with parent driver module reference
> > > counting, rely on "depends on" keyword to ensure that proper
> > > probe/remove chain is performed.
> >
> > ?? kconfig doesn't impact module ordering.
>
> Yeah, I was fast with the typing.
>
> >
> > To have a proper remove chain there should be a symbol reference from
> > bnxt_re to whatever the other module is
>
> Right, they have probe_ulp() calls or something.
>
> >
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > >  drivers/infiniband/hw/bnxt_re/Kconfig |  4 +---
> > >  drivers/infiniband/hw/bnxt_re/main.c  | 20 +++++---------------
> > >  2 files changed, 6 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/bnxt_re/Kconfig b/drivers/infiniband/hw/bnxt_re/Kconfig
> > > index 0feac5132ce1..b4779a6cd565 100644
> > > +++ b/drivers/infiniband/hw/bnxt_re/Kconfig
> > > @@ -2,9 +2,7 @@
> > >  config INFINIBAND_BNXT_RE
> > >     tristate "Broadcom Netxtreme HCA support"
> > >     depends on 64BIT
> > > -   depends on ETHERNET && NETDEVICES && PCI && INET && DCB
> > > -   select NET_VENDOR_BROADCOM
> > > -   select BNXT
> > > +   depends on ETHERNET && NETDEVICES && PCI && INET && DCB && BNXT
> >
> > Though this is correct, BNXT is a 'tristate' so it should be
> > referenced with depends on select.
> >
> > > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> > > index fdb8c2478258..a81adb07e5d9 100644
> > > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > > @@ -561,13 +561,6 @@ static struct bnxt_re_dev *bnxt_re_from_netdev(struct net_device *netdev)
> > >     return container_of(ibdev, struct bnxt_re_dev, ibdev);
> > >  }
> > >
> > > -static void bnxt_re_dev_unprobe(struct net_device *netdev,
> > > -                           struct bnxt_en_dev *en_dev)
> > > -{
> > > -   dev_put(netdev);
> > > -   module_put(en_dev->pdev->driver->driver.owner);
> > > -}
> >
> > And you are right to be wondering WTF is this
> >
> > Jason

Hi Leon and Jason,

Still trying to understand but what's the big idea here may be I can help.

-- 
-Regards
Devesh

--000000000000f135b505be4ad1b5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
TUsFTOuxP4FZ9JSu9FWkGJGPobx8FmEvg+HybmXuUG0+PU7EDHKNoW8AcgZvIQYbwfevqWBFwwRD
Paihaaj18xGk21lqZcO0BecWKYyV4k9E8poof1dH+GnKqwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpkZXZlc2guc2hhcm1hQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEe3qNwswWXCeWt/hTDSC
KajMvUgwDQYJKoZIhvcNAQELBQADggEBAGm+rkHFWdX4Z3YnpNuhM5Sj6w4b4z1pe+LtSquNyt9X
SNuffkoBuPMkEpU3AF9DKJQChG64RAf5UWT/7pOK6lx2kZwhjjXjk9bQVlo6bpojz99/6cqmUyxG
PsH1dIxDlPUxwxCksGuW65DORNZgmD6mIwNhKI4Thtdf5H6zGq2ke0523YysUqecSws1AHeA1B3d
G6Yi9ScSuy1K8yGKKgHn/ZDCLAVEG92Ax5kxUaivh1BLKdo3kZX8Ot/0mmWvFcjEqRyCE5CL9WAo
PU3wdmxYDWOzX5HgFsvArQl4oXob3zKc58TNeGivC9m1KwWJphsMkZNjc2IVVC8gIryWh90xggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwhg1OJo0VLRNay
SHwwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIO5noscdKuk5OguDeheAZP37vCp3
I+H9G30SESMAXYIPMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDMyNDE2MzA0MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAll/ktEAtmQKhT3rYmUdh4l0eUNtbd+U/oep7grWWOrqIx
WOdDCXR+WUc4c36Ki1JEyybo1MZhUABJPHHm2414UnmlT3WJY4qYTlyFCXDu/FxyzgnFkuo+90lC
mD1HFlEKVb019TkIYd+6DBaQxvvuEQL31XDfPlvcH5CJCdtfW96OrfrQiKqeGvuR3pzM2ov4Conv
lbvQBx0TJREVhYEg6mD/qBF7g0Fk2Q5t81GCa8tn/z7J7ltLhpmtx52/ErLo3pqvtXV6zBkk39tb
Vssb9WJK7x8n8rlR0NezWbtsqjEwJcx0GGeqUakAdc4WBdfhXnWPpHpGS28BGH7uAnh+
--000000000000f135b505be4ad1b5--
