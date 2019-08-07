Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 323FD84704
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2019 10:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387534AbfHGIVW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Aug 2019 04:21:22 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:44384 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387498AbfHGIVW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Aug 2019 04:21:22 -0400
Received: by mail-vs1-f43.google.com with SMTP id v129so60121518vsb.11
        for <linux-rdma@vger.kernel.org>; Wed, 07 Aug 2019 01:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4/NN8kt/DikXbQbCkzzACf/+aFjfuZuKWeR8s01pW74=;
        b=EURBAZpzKwS00+Up5Jw7aikFDFBFljj0gQIMjL96AAQTkhzlyA5vTcu3YJw1kWoovN
         KuI3epmFhNcN2J+QP04EaiMTiOaZeyBVtwNYF8bwPPk3W7d056Q5iLECIWWdFAfvSp4r
         bmRAK/LRvWlrpVhG9F2YYsmWJ0cP23KN0WmZFiD9xTqZD24Qix1wvCEt6cP6udjFgP0+
         9nV9luU6GT0bugq40ZhD7z7p56QPbUHxgt2fd2OLTu0X7p1lzjglSpoJ6X4mtA18PpzP
         EcFj8WrSDsjgkl9NZnY3gQG2rrobF1TNxfZK1hyTVr3KF9aRW55zaqD5SJNAttctZtDm
         zxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4/NN8kt/DikXbQbCkzzACf/+aFjfuZuKWeR8s01pW74=;
        b=kI/1/2wLo/OeuKPFdQkA7w423Al+qgjT5rvf7vPqK+TKRFYD+VzWuYUenWmbmhXb31
         LpNcXzBlQJHiDaX9lxlQ8jACHAl0E0vVdP/NKPUTCdihECun0/6oQVS2nAlNPyX/NsmC
         VW1QU27ORfTZY4+/e6BPP9+bYciQM0EJxpOUu84RGx7EHOs50O4/4yWlrrl6jQQQ85B6
         JUWWtRbHa5HZTn9oeWea+BgfYk1F9IElDRpVfB7O6JeKgu6+0VZmr+gqo8QuNL1+fZW1
         WpOf031pqh+VEURGSmkyDIfUd1f0Tz/N9HpdaIhsveB5fxTsigRILtqWNdPsvIo+n4uy
         EPbg==
X-Gm-Message-State: APjAAAXGsZpx3iZcS514pBLiO9lDdq/TPhcATy0koH7FWuBAFzkHIIUm
        ZdU8D2ft0w3oFUkMgJQrlU5zs/sS144BbsWL+arK9Zkd
X-Google-Smtp-Source: APXvYqwYRTkJo6hf+Nv62HZyrENHPoKBfYgYmpywaQNC3YLv0PCP6IAR1LZYAUSNxzIkXDLXN5S6nJORWAN95WX1d7A=
X-Received: by 2002:a67:efd6:: with SMTP id s22mr5044432vsp.47.1565166080952;
 Wed, 07 Aug 2019 01:21:20 -0700 (PDT)
MIME-Version: 1.0
From:   James Harvey <jamespharvey20@gmail.com>
Date:   Wed, 7 Aug 2019 04:21:09 -0400
Message-ID: <CA+X5Wn7kHqGvvyh72MTMo2ACcOe4MXWiD0ZSYCJgM4xCysyBNw@mail.gmail.com>
Subject: rdma-core and infiniband-diags -- so number rollback -- wrong perl
 module location
To:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Looks like rdma-core 25 swallowed infiniband-diags.  Would be nice if
the release notes mentioned that.  (They do include "ibdiags: ..."
style changes, but nothing jumping out that it's been pulled in -
especially like a summary up top for important changes.)  (I do see
the infiniband-diags repo does mention deprecated, use rdma-core.)

I see 2 issues.


(1) so number rollback

The last actual version of infiniband-diags, v2.2.0, released May 12, builds:
* libibmad.so.5.5.0
* libibnetdisc.so.5.3.0

The subsequent version of rdma-core, 25.0, released Jul 29, builds
older so numbers:
* libibmad.so.5.3.25.0
* libibnetdisc.so.5.0.25.0

Weird for newer versions have older so numbers.


(2) wrong perl module location

infiniband-diags correctly installed to
/usr/share/perl5/vendor_perl/IBswcountlimits.pm

rdma-core dropped "vendor_perl" and incorrectly installs to
/usr/share/perl5/IBswcountlimits.pm

I can work around this by adding
"-DCMAKE_INSTALL_PERLDIR='/usr/share/perl5/vendor_perl' \" but wanted
to mention this, since AFAIK the proper location is in "vendor_perl",
where it used to be.
