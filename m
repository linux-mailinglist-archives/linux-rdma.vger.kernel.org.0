Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F032425772
	for <lists+linux-rdma@lfdr.de>; Tue, 21 May 2019 20:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfEUSTv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 May 2019 14:19:51 -0400
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:55286 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728055AbfEUSTv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 May 2019 14:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1558462790;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=s8+dxC6I4gZ+1Z5m3yb4AD02Fo2N9dpOH/Pdr4SH3aA=;
        b=PQczR/Ec85bueMrby4333m4J/1wHIwDZxi0cbHLkxNmG90tG98H5KTkPgcIjcFFZ
        7pcDG2H8UwizE16nOHzRwrh9E3Uj5SDOHEc5cZe7eN35Vz8xEDoS5WtKVjo8Byzn0uK
        APEqONp85ccl5bZ8PIZhmWuHLV/q9r7lZ8Cx06Lg=
Date:   Tue, 21 May 2019 18:19:50 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Steve Wise <larrystevenwise@gmail.com>
cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: rdma-core debian packages
In-Reply-To: <CADmRdJe-mk0TQBno1yaAcRH4hrV=kHAyNtX7dmQ4vfucZtRNmQ@mail.gmail.com>
Message-ID: <0100016adb9ef962-1116974f-a557-4f0d-8cd2-4f2a8192f0c1-000000@email.amazonses.com>
References: <CADmRdJdS8EF99MprTPBmcQwjwB0sV29iHTk4C+eCPDwifAyEBw@mail.gmail.com> <0100016ac67378f1-7e828df6-cebc-4c44-8e88-00503869d453-000000@email.amazonses.com> <CADmRdJe-mk0TQBno1yaAcRH4hrV=kHAyNtX7dmQ4vfucZtRNmQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.05.21-54.240.9.46
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 17 May 2019, Steve Wise wrote:

> On Fri, May 17, 2019 at 10:40 AM Christopher Lameter <cl@linux.com> wrote:
> >
> > On Fri, 17 May 2019, Steve Wise wrote:
> >
> > > Is there a how-to somewhere on building the Debian rdma-core packages?
> >
> > README.md?
> >
>
> The README.md file doesn't explain how to create packages to install
> with 'apt-get'.

I would think that the best and most up to date information for such
builds can be found in the source packages of the distro (Debian/Ubuntu).
