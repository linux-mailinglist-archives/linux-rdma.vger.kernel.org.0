Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2769F14F680
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Feb 2020 06:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgBAFAh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 Feb 2020 00:00:37 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42263 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgBAFAh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 1 Feb 2020 00:00:37 -0500
Received: by mail-ed1-f50.google.com with SMTP id e10so10032547edv.9
        for <linux-rdma@vger.kernel.org>; Fri, 31 Jan 2020 21:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imatrex-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=cCSDQTKZ7QjU/qnqm6YQj5eK0t//+T9cOaSzD2vYJtw=;
        b=O3ljpJ+05Uu0A1u0xA53378VhZaC3yQK4I1n+LczVM2pTxGblwKe4/9rLP/WPGNnFV
         WggIfShTeB4iiKR2Sb4IqH8KKoU+SwORmnGzttFwMGHyP1g98ebzNICHbh73ExNlUHYm
         Pkm5B9B5JBhlCHmnEDjH2olljOgCU/vhFQsts1++d5kOPTbAeaZeQ7syUryRZhNrCKgA
         YTKHR3IBO0lZ6P/FrPbixyQDHVZBcjzm68LziWHGwKIZmMO+weeUH80SzrdPBfs9z65T
         AHMSbv5SOZSuuV/35tq6MmjxuIAGfCPMrXgqFSl6hdpReHoESgKMugfjXvkoKYZqornn
         VABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=cCSDQTKZ7QjU/qnqm6YQj5eK0t//+T9cOaSzD2vYJtw=;
        b=RIY/vFp8SJ9QCP94FOOnln+eRk/xiLdp8QWWqy02uROZ2ZIcj0sekrT+0fTV5eNNGg
         Al3s19whwS7WVNc/lgvGKY1akSm9pfv30TPsceOmDr7k+XRqYXVT58N/I5ei3tFB+dnL
         WEfxjQbMEhMPRapppAf3Xcou6eRZND6mmFA/+oz00Q4ozNyR9Xxx7HS3jIJgMRpWxAKm
         yEw/bl+1+K0OhRylgUaKZIofQ88meM9B0wqu1Z9GL2kHLES4RRsYh5cAR0hT3PCtRXU2
         uKU9pqwlMPuQQMH2kqKkW0t3+5Y5N3yNiiG/Ac67rPAi/e0uzwf89ENGwvaE3w/58q9e
         2+fQ==
X-Gm-Message-State: APjAAAUrW9JIY7xo7tD7NRMjBHakD4OKXWN4ARmKwriUk6dEJFceElD7
        Zu+wevCEy8Jh84S2g+DbndrdmNV8Gx8ruNTIwqy4Kl8xdlg=
X-Google-Smtp-Source: APXvYqwjiL2RC/XnuXLHOwfMrc0PSgRvFromXxjYwqomUJa1GsXAr/4LzdLNMrjbsqtiq/yUZ5aJuhCFrqxlsI0uEdY=
X-Received: by 2002:a05:6402:298:: with SMTP id l24mr3497310edv.70.1580533234115;
 Fri, 31 Jan 2020 21:00:34 -0800 (PST)
MIME-Version: 1.0
From:   Dimitrios Dimitropoulos <d.dimitropoulos@imatrex.com>
Date:   Fri, 31 Jan 2020 21:00:24 -0800
Message-ID: <CAOc41xEmgiw_xekLuhi6uYZ+rKdMrv=5wOJWKisbpYPpBJsdkA@mail.gmail.com>
Subject: RDMA without rdma_create_event_channel()
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

I'm looking to connect an RDMA hardware accelerator to a Centos 8.0
server with RoCE_V2 capability.

Is there a way to implement RDMA RC functionality without invoking the
Connection Manager (skipping the rdma_create_event_channel()) ?
Perhaps with a simple exchange of the necessary information through an
external protocol, say UDP packets ? And then initialize the QPs with
the received parameters.

A bit unsure if this is the appropriate forum for it, let me know if
it's off topic.

Regards,
Dimitris
